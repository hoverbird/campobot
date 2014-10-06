# Description:
#   Add a story to pivotal tracker
#
# Dependencies:
#   "xml2js": "0.1.14"
#
# Configuration:
#   HUBOT_PIVOTAL_TOKEN
#   HUBOT_PIVOTAL_PROJECT
#
# Commands:
#   pivotal add story type name - Adds a story to pivotal tracker
#
# Authors:
#   christianchristensen

module.exports = (robot) ->
   robot.hear /(pivotal add story)/, (msg)->
    xml2js = require('xml2js')
    Parser = new xml2js.Parser(xml2js.defaults["0.1"])
    token = process.env.HUBOT_PIVOTAL_TOKEN
    project_id = process.env.HUBOT_PIVOTAL_PROJECT
    story_name = encodeURIComponent(msg.match[3])
    story_type = encodeURIComponent(msg.match[2])
    requested_by = msg.message.user.name

    (new Parser).parseString body, (err, json)->
        msg.http("https://www.pivotaltracker.com/services/v3/projects/#{project_id}/stories?story[name]=#{story_name}&story[story_type]=#{story_type}&story[requested_by]=#{requested_by}").headers("X-TrackerToken": token).post() (err, res, body) ->
          if err
            msg.send "Pivotal says: #{err}"
            return
          if res.statusCode != 500
            (new Parser).parseString body, (err, story)->
              if !story.id
                return
              message = "# Story Created: "
              message += "#{story.id['#']} #{story.name}"
              message += " (#{story.type})"
              message += " (#{story.owned_by})" if story.owned_by
              message += " is #{story.current_state}" if story.current_state && story.current_state != "unstarted"
              msg.send message
              storyReturned = true
              return
    return

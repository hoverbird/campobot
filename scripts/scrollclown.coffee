module.exports = (robot) ->

  robot.respond /scrollclown( me)?/i, (msg) ->
    msg.send "http://phenry.s3.amazonaws.com/scrollclown.gif"

  robot.respond /scrollbuckle( me)?/i, (msg) ->
    msg.send "http://phenry.s3.amazonaws.com/scrollbuckle.jpg"

  robot.respond /scrollfield|scrollgarfield|scroll garfield/i, (msg) ->
    msg.send "http://phenry.s3.amazonaws.com/scrollfield.jpg"

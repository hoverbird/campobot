# Description:
#   A simple interaction with the built in HTTP Daemon
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# URLS:
#   /hubot/version
#   /hubot/ping
#   /hubot/time
#   /hubot/info
#   /hubot/ip

fs = require('fs')
spawn = require('child_process').spawn
forrest_img = fs.readFileSync('./forrest-head.svg');
forrest_html = fs.readFileSync('./forrest_sez.html.mustache', 'utf-8');

module.exports = (robot) ->
  getMessage = ->
    if robot.brain.byrnesMessages
      robot.brain.byrnesMessages[robot.brain.byrnesMessages.length - 1]
    else
      text: "SWEAR THAT YOU WILL HATE ALL FIRE", foregroundColor: '#C39F69', backgroundColor: 'red'

  robot.router.get "/img/forrest_sez.svg", (req, res) ->
    res.writeHead(200, {'Content-Type': 'image/svg+xml' });
    res.end(forrest_img);

  robot.router.get "/forrest/sez", (req, res) ->
    message = getMessage()
    html = forrest_html.replace(/{{byrnes_message}}/g, message.text).replace(/{{foreground_color}}/g, message.foregroundColor).replace(/{{background_color}}/g, message.backgroundColor)
    res.end html

  robot.router.get "/forrest/update", (req, res) ->
    responseData = message: getMessage()
    res.writeHead 200, { 'Content-Type': 'application/json' }
    res.write(JSON.stringify(responseData))
    res.end()
  robot.router.get "/hubot/version", (req, res) ->
    res.end robot.version

  robot.router.post "/hubot/ping", (req, res) ->
    res.end "PONG"

  robot.router.get "/hubot/fired", (req, res) ->
    firedCounts = []
    for own key, user of robot.brain.data.users
      user.firedCount or= 0
      firedCounts.push(
        title: user.name,
        value: user.firedCount
      )

    graph = "graph": {
      "title" : "FiredWatch",
      "datasequences": [
        "title": "Times Fired"
        "color" : "red",
        "refreshEveryNSeconds" : 120,
        "datapoints" : firedCounts
      ]
    }
    res.end JSON.stringify(graph)

  robot.router.get "/hubot/time", (req, res) ->
    res.end "Server time is: #{new Date()}"

  robot.router.get "/hubot/info", (req, res) ->
    child = spawn('/bin/sh', ['-c', "echo I\\'m $LOGNAME@$(hostname):$(pwd) \\($(git rev-parse HEAD)\\)"])

    child.stdout.on 'data', (data) ->
      res.end "#{data.toString().trim()} running node #{process.version} [pid: #{process.pid}]"
      child.stdin.end()

  robot.router.get "/hubot/ip", (req, res) ->
    robot.http('http://ifconfig.me/ip').get() (err, r, body) ->
      res.end body

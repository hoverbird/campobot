byrnesResponses = [
  "OK"
  "Will do."
  "On it."
  "Sure."
]

defaultForegroundColor = "#C39F69"
defaultBackgroundColor = "red"
# old RE: /say "(.*)" ?(\w* \w*)?$/i

module.exports = (robot) ->
  robot.respond /say "(.*)" ?([#a-zA-Z0-9]*)?$/i, (msg) ->
    message = text: msg.match[1].trim()
    message.backgroundColor = defaultBackgroundColor

    color = msg.match[2]

    if color
      message.foregroundColor = color
    else
      message.foregroundColor = defaultForegroundColor

    robot.brain.byrnesMessages = robot.brain.byrnesMessages or []
    robot.brain.byrnesMessages.push(message)
    msg.send msg.random(byrnesResponses)

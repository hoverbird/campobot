byrnesResponses = [
  "OK"
  "Will do."
  "On it."
  "Sure."
]

defaultForegroundColor = "green"
defaultBackgroundColor = "red"

module.exports = (robot) ->
              # /say "(.*)" ?(\w* \w*)?$/i
  robot.respond /say "(.*)" ?(\w* \w*)?$/i, (msg) ->
    message = text: msg.match[1].trim()
    colorLine = msg.match[2]
    colors = colorLine.split(' ')

    if colors and colors.length is 2
      message.backgroundColor = colors[0]
      message.foregroundColor = colors[1]
      msg.send message.backgroundColor
      msg.send message.foregroundColor
    else
      message.backgroundColor = defaultBackgroundColor
      message.foregroundColor = defaultForegroundColor

    robot.brain.byrnesMessages = robot.brain.byrnesMessages or []
    robot.brain.byrnesMessages.push(message)
    msg.send msg.random(byrnesResponses)

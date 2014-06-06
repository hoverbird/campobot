# Description:
#   Utility commands surrounding Hubot uptime.
#
# Commands:
#   hubot ping - Reply with pong
#   hubot echo <text> - Reply back with <text>
#   hubot time - Reply with current time
#   hubot die - End hubot process

miloPunishments = [
  "Milo! Go to your room."
  "Milo, you've been very bad today. No murdering snails for 2 weeks."
  "MILO! YOU ARE GOING TO BED MISTER. Without supper."
  "You're in punishment, Milo."
  "You're on time out, Milo. 10 minutes. Starting now."
  "I'm not mad, Milo. I'm just disappointed. What is Molyneux going to say when he gets home?"
]

module.exports = (robot) ->
  robot.respond /punish milo/i, (msg) ->
    msg.send msg.random(miloPunishments)

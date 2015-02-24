module.exports = (robot) ->
  robot.hear /it'?s? working/i, (msg) ->
  	msg.send "http://phenry.s3.amazonaws.com/its-working.gif"
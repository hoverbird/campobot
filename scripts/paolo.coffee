# Because every bot needs a little paolo
module.exports = (robot) ->

  robot.respond /paolo( me)?$/i, (msg) ->
    msg.send "@everyone do this when you get the latest please:"
    msg.send "http://camposantobot.s3.amazonaws.com/paolo_loves_reimporting.png"

  robot.respond /paolo unity/i, (msg) ->
    msg.send 'I HAVE SPENT THE WHOLE DAY BANGING MY HEAD AGAINST A WALL'
    msg.send 'BUT IT IS A WALL OF DIAMONDS'
    msg.send '...'
    msg.send 'WITH A FAT FRENCH PRINCE BEHIND IT AND HE IS YELLING "YOURE NEVER GOING TO BREAK DOWN MY WALL"'

  robot.respond /campobot/i, (msg) ->
    msg.send "campobot image me that's so meta"
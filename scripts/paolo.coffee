# Because every bot needs a little paolo
module.exports = (robot) ->

  robot.respond /paolo( me)?$/i, (msg) ->
    msg.send "@everyone do this when you get the latest please: https://campo.slack.com/files/paolo/F02FBEBLD/2014-08-05_14_40_02-unity_-_teenloop.unity_-_wyoming_-_pc__mac___linux_standalone___dx11_.png"
    msg.send "https://campo.slack.com/files/paolo/F02FBEBLD/2014-08-05_14_40_02-unity_-_teenloop.unity_-_wyoming_-_pc__mac___linux_standalone___dx11_.png"

  robot.respond /paolo unity/i, (msg) ->
    msg.send 'I HAVE SPENT THE WHOLE DAY BANGING MY HEAD AGAINST A WALL'
    msg.send 'BUT IT IS A WALL OF DIAMONDS'
    msg.send '...'
    msg.send 'WITH A FAT FRENCH PRINCE BEHIND IT AND HE IS YELLING "YOURE NEVER GOING TO BREAK DOWN MY WALL"'

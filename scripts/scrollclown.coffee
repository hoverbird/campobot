module.exports = (robot) ->

  robot.respond /scrollclown( me)?/i, (msg) ->
    msg.send "http://www.mormonshare.com/sites/default/files/handouts/cg_clown-tall.gif"


  robot.respond /scrollbuckle( me)?/i, (msg) ->
    msg.send "http://pintaw.com/images/wallpapers/Jon_Arbuckle_Wallpaper-by_VGAfanatic.jpg"

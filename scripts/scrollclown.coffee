module.exports = (robot) ->

  robot.respond /scrollclown( me)?/i, (msg) ->
    msg.send "http://phenry.s3.amazonaws.com/cg_clown-tall-624x1462.gif"


  robot.respond /scrollbuckle( me)?/i, (msg) ->
    msg.send "http://pintaw.com/images/wallpapers/Jon_Arbuckle_Wallpaper-by_VGAfanatic.jpg#.png"

    # https://slack-files.com/files-pub/T026T4P9K-F0278GZ93-9dceba/scrollclown.jpg

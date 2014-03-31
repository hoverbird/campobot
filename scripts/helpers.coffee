util = require 'util'

module.exports = (helpers) ->
  helpers.ordinalInWord = (cardinal) ->
    ordinals = [ # and so on up to "twentieth"
      "zeroth"
      "first"
      "second"
      "third"
    ]
    tens =
      20: "twenty"
      30: "thirty"
      40: "forty" # and so on up to 90

    ordinalTens =
      30: "thirtieth"
      40: "fortieth"
      50: "fiftieth" # and so on

    return ordinals[cardinal]  if cardinal <= 20
    return ordinalTens[cardinal]  if cardinal % 10 is 0
    tens[cardinal - (cardinal % 10)] + ordinals[cardinal % 10]

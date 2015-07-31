# Description:
#   Assign roles to people you're chatting with
#
# Commands:
#   hubot <user> is a badass guitarist - assign a role to a user
#   hubot <user> is not a badass guitarist - remove a role from a user
#   hubot who is <user> - see what roles a user has
#
# Examples:
#   hubot holman is an ego surfer
#   hubot holman is not an ego surfer

module.exports = (robot) ->
  _ = require 'lodash'

   # helper function
  ordinalInWord = (cardinal) ->
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

  if process.env.HUBOT_AUTH_ADMIN?
    robot.logger.warning 'The HUBOT_AUTH_ADMIN environment variable is set not going to load roles.coffee, you should delete it'
    return

  getAmbiguousUserText = (users) ->
    "Be more specific, I know #{users.length} people named like that: #{(user.name for user in users).join(", ")}"

  robot.respond /who is @?([\w .\-]+)\?*$/i, (msg) ->
    joiner = ', '
    name = msg.match[1].trim()

    if name is "you"
      msg.send "I'm Campobot. I was built to serve and protect the citizens of Campo Santo."
    else if name is robot.name
      msg.send "The best."
    else if name is "milo"
      msg.send "That little pipsqueak isn't even real. He's just a shitty tech demo. No class."
    else
      users = robot.brain.usersForFuzzyName(name)
      if users.length is 1
        user = users[0]
        user.roles = user.roles or [ ]
        if user.roles.length > 0
          if user.roles.join('').search(',') > -1
            joiner = '; '
          msg.send "#{name} is #{user.roles.join(joiner)}."
        else
          msg.send "#{name} is nothing to me."
      else if users.length > 1
        msg.send getAmbiguousUserText users
      else
        msg.send "#{name}? Never heard of 'em"

  robot.respond /fired count( for)? @?([\w .\-_]+)/i, (msg) ->
    name = msg.match[2].trim()
    user = robot.brain.userForName(name)
    msg.send("Our records show that #{name} has been fired #{user.firedCount} times.")
    if user.firedReasons.length
      msg.send _.unescape("Reasons:\n #{user.firedReasons.join("\n")}.")


  robot.respond /@?([\w .\-_]+) is (["'\w: \-_]+)[.!]*$/i, (msg) ->
    name    = msg.match[1].trim()
    newRole = msg.match[2].trim()

    unless name in ['', 'who', 'what', 'where', 'when', 'why']
      unless newRole.match(/^not\s+/i)
        users = robot.brain.usersForFuzzyName(name)
        if users.length is 1
          user = users[0]
          user.roles = user.roles or [ ]

          if newRole in user.roles
            msg.send "I know"
          else
            user.roles.push(newRole)
            if name.toLowerCase() is robot.name.toLowerCase()
              msg.send "Ok, I am #{newRole}."
            else
              msg.send "Ok, #{name} is #{newRole}."
        else if users.length > 1
          msg.send getAmbiguousUserText users
        else
          msg.send "I don't know anything about #{name}."

  robot.respond /@?([\w .\-_]+) is not (["'\w: \-_]+)[.!]*$/i, (msg) ->
    name    = msg.match[1].trim()
    newRole = msg.match[2].trim()

    unless name in ['', 'who', 'what', 'where', 'when', 'why']
      users = robot.brain.usersForFuzzyName(name)
      if users.length is 1
        user = users[0]
        user.roles = user.roles or [ ]

        if newRole not in user.roles
          msg.send "I know."
        else
          user.roles = (role for role in user.roles when role isnt newRole)
          msg.send "Ok, #{name} is no longer #{newRole}."
      else if users.length > 1
        msg.send getAmbiguousUserText users
      else
        msg.send "I don't know anything about #{name}."

  robot.respond /fire @?([\w.\-_]+\b)( for [\w .!?,"'\-_]+)?/i, (msg) ->
    name   = msg.match[1].trim()
    reason = msg.match[2]

    user = robot.brain.userForName(name)
    user.firedCount or= 0
    user.firedReasons or= []
    user.firedCount++
    if reason
      user.firedReasons.push(_.escape(reason.substr(4)))

    sendoffs = [ "Pack your things", "HR has been notified", "This will be your last day",
                 "I'm gonna need your gun and your badge", "Don't let the door hit ya" ]
    msg.send "You're fired, #{name}. #{msg.random sendoffs}."

  # a pre-shuffled list of winners
  winners = ['paolo', 'patrick', 'jane', 'bunsen', 'sean', 'gabe', 'jake', 'olly', 'chris', 'will']

  robot.respond /pick( me)? a winner/i, (msg) ->
    robot.brain.winnerIndex ?= 0
    winner = winners[robot.brain.winnerIndex]
    if robot.brain.winnerIndex + 1 == winners.length
      robot.brain.winnerIndex = 0
    else
      robot.brain.winnerIndex = robot.brain.winnerIndex++
    msg.send "And the winner is...  ✨#{winner}💫!"

  robot.respond /pick( me)? a rando/i, (msg) ->
    rando = _.shuffle(winners)[0]
    msg.send "I choose you, @#{rando}."


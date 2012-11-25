Rooms = new Meteor.Collection "rooms"
Messages = new Meteor.Collection "messages"
Builders = new Meteor.Collection "builders"

Meteor.startup () ->
  if Rooms.find().count() == 0
    Rooms.insert({
      title:"Singularity",
      description:"You are at the center of the universe.  It's really quiet.",
      initial: true
    })

  Accounts.onCreateUser (o,u) ->
    if o.profile then u.profile = o.profile
    if Meteor.users.find().count() == 0
      if u.profile
        u.profile['admin'] = true
    if u.profile and u.services and u.services.github and u.services.github.username
      u.profile['username'] = u.services.github.username
    u
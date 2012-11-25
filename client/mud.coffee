Rooms = new Meteor.Collection "rooms"
Messages = new Meteor.Collection "messages"
Builders = new Meteor.Collection "builders"

Template.location.created = () ->
  # keyboard navigation
  $(document.body).on 'keyup', (e) ->
    cr  = current_room()
    kc  = { 37: 'west', 38: 'north', 39: 'east', 40: 'south', 85: 'up', 68: 'down' }
    dir = kc[e.keyCode]
    nn  = e.target.nodeName
    if (nn == "INPUT" or nn == "TEXTAREA") and (dir == 'up' or dir == 'down')
      return
    if Template.location.editing() == true
      return

    if current_exits().indexOf(dir) > -1
      Session.set('room',cr[dir])

Template.location.editing = () ->
  Session.get('editing')

Template.navbar.events {
    'click .navbar .add': () ->
      if available_exits().length == 0
        malert('All directions are taken')
  , 'click .navbar .users': () ->
      if !is_admin() then return
      $('#listUsers').modal('show')
}

Template.navbar.canAddRoom = () -> is_builder()

Template.navbar.admin = () -> is_admin()

Template.modals.admin = () -> is_admin()
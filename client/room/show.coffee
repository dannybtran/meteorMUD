Template.showRoom.exits = () ->
  exits = []
  cr = current_room()
  for i,d of dirs
    if cr && cr[d]
      data = {direction: d, room: Rooms.findOne({_id:cr[d]})}
      exits.push(data)
  exits

Template.showRoom.buildExits = () ->
  available_exits()

Template.showRoom.canEdit  = () -> (is_builder() && !current_room().locked) || is_admin()

Template.showRoom.canLock  = () -> is_admin()

Template.showRoom.canAdd   = () -> is_builder() || is_admin()

Template.showRoom.loggedIn = () -> Meteor.user()

Template.showRoom.events {
    'click button.exit': () ->
      Session.set('room',@room._id)
  , 'click button.edit': () ->
      if !Template.showRoom.canEdit() then return
      $S = Session
      k  = 'editing'
      if $S.get(k) then $S.set(k,false) else $S.set(k,true)
      setTimeout () ->
        $('.editRoom .title').select()
      , 100
  , 'click button.lock': () ->
      if !Template.showRoom.canLock() then return
      cr = current_room()
      if cr.locked
        Rooms.update({_id:cr._id},{$set:{locked:false}})
      else
        Rooms.update({_id:cr._id},{$set:{locked:true}})
  , 'click button.build-exit': (e) ->
      if !Template.showRoom.canAdd() then return
      button = $(e.target)
      direction = button.data('direction')
      $('#addRoom').modal('show')
      $('#addRoom option').attr('selected',false)
      $('#addRoom option.'+direction).attr('selected',true)
}
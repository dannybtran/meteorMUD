Template.editRoom.current_room = () ->
  current_room()

Template.editRoom.events {
    'click button.save': (e) ->
      cr          = current_room()
      title       = trim $('.editRoom .title').val()
      description = trim $('.editRoom .description').val()

      if title == ""       then return alert('fill in a title')
      if description == "" then return alert('fill in a description')

      data = {}
      data['title'] = title
      data['description'] = description
      Rooms.update({_id:cr._id},{$set:data})
      Session.set('editing',false)
  , 'click button.cancel': (e) ->
      Session.set('editing',false)
}
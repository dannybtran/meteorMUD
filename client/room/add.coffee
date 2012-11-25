malert = (m) ->
  $('.addRoom .alert-error').html(m).show()

Template.addRoom.exits = () ->
  available_exits()

Template.addRoom.events {
  'click button.add': (e) ->
    cr          = current_room()
    title       = trim $('.addRoom .title').val()
    description = trim $('.addRoom .description').val()
    direction   = trim $('.addRoom .direction').val()

    if title == ""       then return malert('Title required')
    if description == "" then return malert('Description required')
    if direction == ""   then return malert('Direction required')
    if cr[direction]     then return malert('Direction is taken')

    data = { title: title, description: description }
    data[oppdir(direction)] = cr._id
    room = Rooms.insert(data)

    data = {}
    data[direction] = room
    Rooms.update({_id:cr._id},{$set:data})

    $('#addRoom').modal('hide')
}
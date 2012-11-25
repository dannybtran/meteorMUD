create_message = (msg) ->
  if msg == "" then return

  if user = Meteor.user()
    data = {}
    data['user']      = user._id
    data['room']      = current_room()._id
    data['message']   = msg
    data['timestamp'] = new Date().toUTCString()
    Messages.insert(data)

  setTimeout () ->
    $('.message').focus()
  , 0

Template.chat.messages = () ->
  cr = current_room()
  if cr
    msg = Messages.find({room: cr._id},{sort:{timestamp: 1}}).fetch()
    messages = _.map msg.slice(-100), (m) ->
      user = Meteor.users.findOne({_id:m.user})
      "<b>"+user.profile.username + "</b>: " + m.message
    messages

Template.chat.rendered = () ->
  $('.chatlog')[0].scrollTop = $('.chatlog')[0].scrollHeight

Template.chat.events {
    'click .send': (e) ->
      create_message trim($('.message').val())
  , 'keypress .message': (e) ->
      if e.keyCode == 13
        create_message trim($('.message').val())

}
keyupTimeout = 0

Template.listUsers.events {
    'keyup #listUsers input': (e) ->
      if !is_admin() then return
      clearTimeout keyupTimeout
      tbody = $('#listUsers table tbody')
      q = trim $('#listUsers input').val()
      if !q
        tbody.html ''
        return
      keyupTimeout = setTimeout () ->
        users = Meteor.users.find({"profile.username":new RegExp(".*"+q+".*","i")}).fetch()
        tbody.html ''
        for user in users
          row = $('<tr/>')

          username = $('<td/>',{class: 'username'})
          username.html(user.profile.username)
          row.append username

          admin = $('<td/>')
          admin.html(if user.profile.admin then "admin" else "user")
          row.append admin

          builder = $('<td/>',{class:'builder'})
          link = $('<a/>',{href:'#',class:'toggle-builder','data-user':user._id})
          link.html(if is_builder(user._id) then "yes" else "no")
          builder.html link
          row.append builder

          tbody.append row
      , 300
  , 'click .toggle-builder': (e) ->
      link = $(e.target)
      id   = link.data('user')
      if is_builder(id)
        Builders.remove({user:id})
        link.html 'no'
      else
        Builders.insert({user:id})
        link.html 'yes'
}
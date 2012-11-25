# trim whitespace off front/back of string
trim = (s) -> if s then s.replace(/^[\s\t]+|[\s\t]+$/g,'') else ""

# hash of available directions, the opposite direction
# is the ~ (boolean NOT) of the other direction
dirs = {
    '0':'north','-1':'south'
  , '1':'east' ,'-2':'west'
  , '2':'up'   ,'-3':'down'
}

# determine opposite direction of dir
oppdir = (dir) ->
  for i,d of dirs
    if d == dir then return dirs[~i]

# determine the current room
current_room = () ->
  q = (if r = Session.get('room') then {_id:r}
  else {initial:true})
  Rooms.findOne(q) || {}

available_exits = () ->
  cr = current_room()
  exits = []
  for i,d of dirs
    if cr && !cr[d] then exits.push(d)
  exits

current_exits = () ->
  cr = current_room()
  exits = []
  for i,d of dirs
    if cr && cr[d] then exits.push(d)
  exits

is_admin = () ->
  if u = Meteor.user()
    if u.profile
      u.profile.admin

is_builder = (id) ->
  if u = Meteor.user() then uid = u._id
  if id then uid = id
  Builders.findOne({user:uid||-1})

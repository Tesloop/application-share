
if Meteor.isServer
	Meteor.publish 'cars', ->
		user = Meteor.users.findOne(@userId)
		if user and user.role == 'admin'
			return Cars.find()
		return Cars.find()

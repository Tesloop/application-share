
if Meteor.isServer
	Meteor.publish 'couponcodes', (couponcodeId) ->
		if couponcodeId
			return Couponcodes.find(couponcodeId)
		Couponcodes.find()

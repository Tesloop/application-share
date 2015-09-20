root = this ? global ? window

if Meteor.isServer
	Meteor.publish "readRoute", (routeId) ->
		return Routes.find(routeId,
			limit: 1
		)

	Meteor.publish 'routes', (routeId) ->
		if routeId
			return Routes.find(routeId)
		Routes.find()

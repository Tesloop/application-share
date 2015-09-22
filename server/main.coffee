Meteor.startup ->
	trip = Trips.findOne()
	console.log 'Trip', trip
	###
	Trips.after.insert( (userId, trip) ->
		console.log('Booking inserted!')
		console.log(trip)
	)
	###

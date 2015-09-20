root = this ? global ? window

if Meteor.isServer
	Meteor.publish 'trip', (tripId) ->
		Trips.find tripId
	Meteor.publish "readTrip", (tripId) ->
		return Trips.find(tripId,
			limit: 1
		)
	Meteor.publish "readTripsForRoute", (routeId) ->
		return Trips.find(
			routeId: routeId
			seatsAvailable:
				$ne: 0
			tripDateTime:
				$gte: new Date()
		,
			limit: 100
			fields:
				tripDateTime: 1
				routeId: 1
				seatsAvailable: 1
				minimumDuration: 1
				maximumDuartion: 1
		)
	Meteor.publish 'tripAndRoute', (tripId) ->
		trip = Trips.find(tripId)
		route = Routes.find(trip.fetch()[0].routeId)
		[
			trip
			route
		]
	Meteor.publish 'tripsWithBookings', (options) ->
		options ?= {}
		options.daysOut ?= 5
		trips = Trips.find(
			hasBookings: true
			tripDateTime:
				$gte: moment().subtract(1, 'days').toDate()
				$lte: moment().add(options.daysOut, 'days').toDate()
		,
			sort:
				tripDateTime: 1
		)
		bookings = Bookings.find(
			tripId:
				$in: _.pluck(trips.fetch(), "_id")
		)
		return [
			trips
			bookings
		]
	Meteor.publish 'tripWithBookings', (tripId)->
		trip = Trips.find( tripId )
		bookings = Bookings.find( tripId: tripId )
		route = Routes.find( Trips.findOne(tripId).routeId )
		return [
			trip
			bookings
			route
		]
	Meteor.publish 'trips', (routeId, date, days) ->
		days = days or 1
		startDate = moment(date).startOf('day').toDate()
		if startDate < moment().toDate()
			startDate = moment().toDate()
		endDate = moment(date).add(days, 'day').startOf('day').toDate()
		query =
			$or: [
				tripDateTime:
					$gte: startDate
					$lt: endDate
			,
				"possibleTripDateTimes.tripDateTime":
					$gte: startDate
					$lt: endDate
			]
		query.hasBookings = true
		if routeId then query.routeId = routeId
		Trips.find query

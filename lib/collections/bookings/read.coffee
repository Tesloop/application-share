root = this ? global ? window

if Meteor.isServer
	Meteor.publish "readBooking", (bookingId) ->
		return Bookings.find(bookingId,
			limit: 1
		)

	Meteor.publish 'bookingAndTrip', (bookingId) ->
		if !bookingId
			return
		booking = Bookings.find(
			_id: bookingId
			type: 'tripConfirmation'
		,
			limit: 1
		)
		tripId = booking.fetch()[0].tripId
		trip   = Trips.find(tripId)
		routes = Routes.find(trip.fetch()[0].routeId)
		return [
			booking
			trip
			routes
		]

root = this ? global ? window

root.Bookings = new Mongo.Collection('bookings')

Schema = {}

Schema.User = new SimpleSchema
	firstName:
		type: String
		optional: false
	lastName:
		type: String
		optional: false
	phoneNumber:
		type: String
		optional: true
	email:
		type: String
		optional: true

Schema.Stop = new SimpleSchema
	name:
		type: String
		optional: false
	offsetInMinutes:
		type: Number
		optional: false
	latitude:
		type: Number
		optional: false
	longitude:
		type: Number
		optional: false

Schema.Booking = new SimpleSchema
	# User and Passengers
	user:
		type: Schema.User
		optional: false
	passengers:
		type: Array
		optional: false
	'passengers.$':
		type: Schema.User
		optional: false
	stripeEmail:
		type: String
		optional: false
	stripeChargeId:
		type: String
		optional: false
	# Trip Specifics
	tripId:
		type: String
		optional: false
	origin:
		type: String
		optional: false
	pickup:
		type: Schema.Stop
		optional: false
	destination:
		type: String
		optional: false
	dropoff:
		type: Schema.Stop
		optional: false
	seats:
		type: [String]
		optional: false
	tripDateTime:
		type: Date
		optional: false
	bookingDateTime:
		type: Date
		optional: false
	calendarEventId:
		type: String
		optional: true
	couponCodeUsed:
		type: String
		optional: false
	createdAt:
		type: Date
		autoValue: ->
			if @isInsert
				return new Date
			else if @isUpsert
				return { $setOnInsert: new Date }
			else
				@unset()
				# Prevent user from supplying their own value
			return

	#Old keys and values
	pickupPoints:
		type: [String]
		optional: true
	dropoffPoints:
		type: [String]
		optional: true
	stops:
		type: [String]
		optional: true
	status:
		type: Object
		optional: true
		blackbox: true


root.Bookings.attachSchema(Schema.Booking)


Bookings.allow
	insert: -> true
	update: -> true
	remove: -> true

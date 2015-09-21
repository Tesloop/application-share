root = this ? global ? window

root.Bookings = new Mongo.Collection('bookings')

Schema = {}

Schema.User = new SimpleSchema
	firstName:
		type: String
	lastName:
		type: String
	phoneNumber:
		type: String
	email:
		type: String

Schema.Booking = new SimpleSchema
	user:
		type: Schema.User
	passengers:
		type: Array
	'passengers.$':
		type: Schema.User
	createdAt:
		type: Date


root.Bookings.attachSchema( new SimpleSchema)


FlowRouter.route '/share-example',
	name: 'shareExample'
	triggersEnter: [
		(context, redirect) ->
			return
	]
	subscriptions: (params, queryParams) ->
		#@register 'booking', Meteor.subscribe('readBooking', queryParams.bookingId)
		return
	action: ->
		BlazeLayout.render('layout',
			header: 'layoutHeader'
			navigationDrawer: 'navigationDrawer'
			page: 'shareExample'
			fullHeight: false
		)

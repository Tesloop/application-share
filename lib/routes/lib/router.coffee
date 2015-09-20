root = this ? global ? window

root.Tesloop ?= {}

if Meteor.isClient
	BlazeLayout.setRoot('body')
	root.Tesloop.headerCrumb ?= new ReactiveVar

FlowRouter.notFound = action: ->
	BlazeLayout.render 'layout', page: 'notFound'

lastRoute = undefined
FlowRouter.triggers.enter [
	# Store the lastRoutePath in the router
	(context) ->
		newRoute =
			path: context.path
			name: context.route.name
		FlowRouter.lastRoute = lastRoute
		lastRoute = newRoute
]

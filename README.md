## Tesloop

At the top of the file there should be a short introduction and/ or overview that explains **what** the project is. This description should match descriptions added for package managers (Gemspec, package.json, etc.)

## Quick Start

Since Meteor's packaging system is still somewhat gimp, you have to do the following to get this package fully functioning (working).
<br>
<br>
Add a *.bowerrc* file in the root of your project directory

	{
		"directory": "public/bower"
	}

Run the following in the root of the meteor project

	bower install --save PolymerElements/paper-drawer-panel#^1.0.0 PolymerElements/paper-header-panel#^1.0.0 PolymerElements/paper-toast#^1.0.0 PolymerElements/paper-toolbar#^1.0.0

Create an *scss.json* file in the root directory with the following

	{
		"useIndex": true,
		"indexFilePath": "client/lib/styles/main.scss",
		"enableAutoprefixer": true,
		"autoprefixerOptions": {
			"browsers": ["> 5%"],
			"cascade": false
		}
	}

Add content to templates

	<template name="navigationDrawerContent">
		The navigation drawer content goes here...
	</template>
	<template name="layoutHeaderContent">
		The navigation drawer content goes here...
	</template>

Route pages and templates like so


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
			)


## Contributors

* "blah" [blah@tesloop.com](email:blah@tesloop.com)

## License

MIT: http://rem.mit-license.org

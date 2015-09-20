Package.describe({
	name: 'tesloop:application-share',
	version: '0.0.1',
	// Brief, one-line summary of the package.
	summary: 'The application share for Tesloop\'s web and mobile applications.',
	// URL to the Git repository containing the source code for this package.
	git: '',
	// By default, Meteor will default to using README.md for documentation.
	// To avoid submitting documentation, set this field to null.
	documentation: 'README.md'
});

Package.onUse(function(api) {
	api.versionsFrom('1.1.0.3');
	// ------ Packages ------
	// Only this Package
	api.use([
		'stylus@1.0.0 || 2.0.0'
	]);
	// This Package and User
	packages = [
		// necessary
		'meteor-platform',
		'email',
		'http',
		'reactive-var',
		'reactive-dict',
		'coffeescript',
		'fourseven:scss@3.2.0',
		'accounts-password',
		'accounts-ui',

		// pretty important general use
		'meteorhacks:picker@1.0.3',
		'meteorhacks:npm@1.5.0',
		'mquandalle:bower@1.4.0',

		// layout and routing with animations
		'kadira:flow-router@2.6.1',
		'kadira:blaze-layout@2.1.0',
		'meteorhacks:fast-render@2.10.0',
		'philippspo:momentum-flow-router@0.0.5',
		'percolate:momentum@0.7.2',

		// somewhat less specific
		//'msavin:mongol',
		'sacha:spin@2.3.1',
		'dapearce:material-icons@0.1.2'
	];
	api.use(packages);
	api.imply(packages);

	// ------ Add Meteor files ------
	// Client & Server
	api.addFiles([
		'scss.json',
		'bower.json',
		// Collections
		'lib/collections/bookings/lib/bookings.coffee',
		'lib/collections/bookings/read.coffee',
		'lib/collections/cars/lib/cars.coffee',
		'lib/collections/cars/read.coffee',
		'lib/collections/couponcodes/lib/couponcodes.coffee',
		'lib/collections/couponcodes/read.coffee',
		'lib/collections/removed-bookings/lib/removed-bookings.coffee',
		'lib/collections/removed-bookings/read.coffee',
		'lib/collections/removed-trips/lib/removed-trips.coffee',
		'lib/collections/removed-trips/read.coffee',
		'lib/collections/routes/lib/routes.coffee',
		'lib/collections/routes/read.coffee',
		'lib/collections/trips/lib/trips.coffee',
		'lib/collections/trips/read.coffee',
		// Routes
		'lib/routes/lib/transitions.coffee',
		'lib/routes/lib/router.coffee',
		'lib/routes/share-example/share-example.coffee'
	], ['client', 'server']);

	// Client
	api.addFiles([
		'client/main.sass',
		'client/lib/styles/pageTransitions.styl',

		'client/components/layout/layout.html',
		'client/components/layout/layout.coffee',

		'client/components/layout-header/layout-header.html',
		'client/components/layout-header/layout-header.coffee',
		'client/components/navigation-drawer/navigation-drawer.html',
		'client/components/navigation-drawer/navigation-drawer.coffee',

		'client/pages/not-found/not-found.html',
		'client/pages/share-example/share-example.html',

		'client/main.html'
	], ['client']);

	// Server
	api.addFiles([

	], ['server']);

	// ------ Add static files ------
	if(typeof api.addAssets === "function"){
		api.addAssets([
			'public/favicon.png',
			// Style Imports
			'variables.sass',
		], ['client']);
	} else {
		api.addFiles([
			'public/favicon.png',
			// Style Imports
			'variables.sass'
		], ['client'], {
			isAsset: true
		});
	}


	/* Switched to using this. instead of global
	Globals aren't exporting correctly for some reason
	// ------ Globals ------
	api.export('Tesloop');

	// Collections
	api.export('Bookings');
	api.export('Cars');
	api.export('Couponcodes');
	api.export('RemovedBookings');
	api.export('RemovedTrips');
	api.export('Routes');
	api.export('Trips');
	*/
});

Package.onTest(function(api) {
	api.use('tinytest');
	api.use('tesloop:application-share');

	api.addFiles('application-share-tests.js');
});

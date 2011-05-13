# Fitgem Client Application #

An example Rails 3 application that uses the <tt>fitbit</tt> gem to query the Fitbit OAuth API, and accepts 
subscription notifications from Fitbit when a user's data changes.

## Usage ##

Goal: Clone the code and you can see the way that the gem is used.

The site started as a way to test how fitbit sends its subscription information.  Since their [dev api website](http://wiki.fitbit.com/display/API/Subscriptions-API) is a little light specific information about notifications I thought I'd set up a site and capture the incoming data.

The plan is to extend the site and eventually use it as a usable example of how to use the [fitbit gem](https://github.com/whazzmaster/fitbit) in web applications.

## Caveats ##

This reference application is intended to illustrate, in real Rails 3 code, how to use the [fitbit gem](http://rubygems.org/gems/fitbit) to connect to
fitbit.com via their REST API and get/set data.  

The application is deployed at [http://fitbitclient.com](http://fitbitclient.com), but I have removed all deployment-specific information from the code in this repository. Unfortunately, for now the view code is littered with references to the site where I have deployed it (liftr.co).  I'll work to remove these so that the demo is just a generic version of fitbit integration as opposed to being organized around integration with a specific site.

__To run this app locally in a dev environment__ you will need to:

* Create <tt>config/app_config.yml</tt> with:

	development:
	  fitbit_consumer_key: {your fitbit consumer key}
	  fitbit_consumer_secret: {your fitbit consumer secret}

	test:
	  fitbit_consumer_key: {your fitbit consumer key}
	  fitbit_consumer_secret: {your fitbit consumer secret}

	production:
	  fitbit_consumer_key: {your fitbit consumer key}
	  fitbit_consumer_secret: {your fitbit consumer secret}
* Create a database.yml for your development environment
* Capify and customize to your environment if you really want to try and deploy it.

#  Contributing to fitbit-client #

I'd like to develop this reference app out quite a bit more to show examples of all functionality within the fitbit gem.  If you have ideas or suggestions about where to first
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. 

### Copyright ###

Copyright (c) 2011 Zachery Moneypenny. See LICENSE.txt for further details.

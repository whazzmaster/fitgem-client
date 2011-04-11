= Fitbit Client Application =

An example Rails 3 application that uses the <tt>fitbit</tt> gem to query the Fitbit OAuth API, and accepts 
subscription notifications from Fitbit when a user's data changes.

== Usage ==

Goal: Clone the code and you can see the way that the gem is used.

The site started as a way to test how fitbit sends its subscription information.  Since their [dev api website](http://wiki.fitbit.com/display/API/Subscriptions-API) is a little light specific information about notifications I thought I'd set up a site and capture the incoming data.

The plan is to extend the site and eventually use it as a usable example of how to use the [fitbit gem](https://github.com/whazzmaster/fitbit) in web applications.
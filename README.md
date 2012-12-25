# Fitgem Client Application #

A Rails 3.x-based reference application that shows how to use the Fitbit gem to query the Fitbit OAuth API. It's publicly available at **[fitbitclient.com](http://fitbitclient.com)**.

The site started as a way to test how fitbit sends its subscription information.  Since their [Developer API website](http://wiki.fitbit.com/display/API/Subscriptions-API) is a little light specific information about notifications I thought I'd set up a site and capture the incoming data.

The site is also meant to be documentation for how to use the [fitbit gem](https://github.com/whazzmaster/fitbit) in web applications.

## Usage

**Step 1**: Clone the reference app locally

~~~~
$ git clone https://github.com/whazzmaster/fitgem-client.git
~~~~

**Step 2**: Install gems

~~~~
$ bundle install
~~~~

**Step 3**: Set your personal fitbit API key and secret.

Go to the [Fitbit Developer Site](http://dev.fitbit.com) and create a test application in order to get a Consumer Key and Consumer Secret. The application looks for the key and secret via two environment variables: **FITBIT\_CONSUMER\_KEY** and **FITBIT\_CONSUMER\_SECRET**.

If you're using [pow](http://pow.cx) to serve Rails apps locally then you can add the following lines to the application's <tt>.powrc</tt> file:

~~~~
export FITBIT_CONSUMER_KEY="<your consumer key here>"
export FITBIT_CONSUMER_SECRET="<your consumer secret here>"
~~~~

Otherwise you must set the environment variables appropriately for your local hosting solution.

**Step 4**: Setup the database.

You can either use the postgresql username/password that the app defines ('fitgemclient'/'fitgemclient'), or you can edit <tt>config/database.yml</tt> to configure the application to use the postgresql username/password that you already have.

Once the user is setup, create the database and run the migrations:

~~~~
$ rake db:create
...various output...
$ rake db:migrate
...various output...
~~~~

**Step 5**: Open the application.

Use <tt>rails s</tt> or create a pow configuration for the app, and then open your browser to the appropriate local URL.  You should now be able to view the site, create an account, link it with Fitbit, etc.

##  Contributing to fitbit-client

I'd like to develop this reference app out quite a bit more to show examples of all functionality within the fitbit gem.  Check out the [issues page](https://github.com/whazzmaster/fitgem-client/issues) to discover areas that you can help develop.

If you have ideas or suggestions then please...

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history.

### Contributors

[https://github.com/whazzmaster/fitgem-client/graphs/contributors](https://github.com/whazzmaster/fitgem-client/graphs/contributors)

### Copyright

Copyright 2011-2012 Zachery Moneypenny. See LICENSE.txt for further details.
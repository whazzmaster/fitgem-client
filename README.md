# Fitgem Client Application

A Rails 3.2-based reference application that shows how to use [fitgem](https://github.com/whazzmaster/fitgem)
to query the [Fitbit API](https://wiki.fitbit.com/display/API/Fitbit+API). **This application is publicly available at
[fitbitclient.com](http://fitbitclient.com)**.

The site is also meant to be documentation for how to use [fitgem](https://github.com/whazzmaster/fitgem)
in ruby web applications.

## Usage

**Step 1**: Clone the reference app locally or fork the repo!

```bash
$ git clone https://github.com/whazzmaster/fitgem-client.git
```

**Step 2**: Install gems

```bash
$ bundle install
```

**Step 3**: Set your personal fitbit API key and secret.

Go to the [Fitbit Developer Site](http://dev.fitbit.com) and create a test application in order to get a Consumer Key
and Consumer Secret. The application looks for the key and secret via two environment variables: `FITBIT_CONSUMER_KEY`
and `FITBIT_CONSUMER_SECRET`.

If you're using [pow](http://pow.cx) to serve Rails apps locally then you can add the following lines to the
application's `.powrc` file:

```bash
export FITBIT_CONSUMER_KEY="<your consumer key here>"
export FITBIT_CONSUMER_SECRET="<your consumer secret here>"
```

Otherwise you must set the environment variables appropriately for your local hosting solution.

**Step 4**: Setup the database.

You can either use the postgresql username/password that the app defines ('fitgemclient'/'fitgemclient'), or you
can edit `config/database.yml` to configure the application to use the postgresql username/password that
you already have.

Once the user is setup, create the database and run the migrations:

```bash
$ rake db:create
...various output...
$ rake db:migrate
...various output...
```

**Step 5**: Open the application.

Use `rails server` or create a [pow configuration](http://pow.cx) for the app, and then open your browser to the appropriate local URL.
You should now be able to view the site, create an account, link it with Fitbit, etc.

##  We Want Your Contributions!

I'd like to develop this reference app out quite a bit more to show examples of all functionality within the fitbit gem.
Check out the [issues page](https://github.com/whazzmaster/fitgem-client/issues) to discover areas that you (yes YOU!)
can help with.

Since this is a documentation/example-centered application **you can have a big impact** by...

* Adding an example of an unexplored resource
* Updating an example
* Copyediting my example text
* Adding a logo for the reference app (as you can tell from the usage of bootstrap I'm not a design genius)
* Providing feedback on the existing documentation. If something doesn't make sense and could be clarified please
let me know!

If you have feedback that doesn't involve writing new code please
[create an issue](https://github.com/whazzmaster/fitgem-client/issues) and describe the feedback. I'm also always pleased
to accept pull requests if you improve the code; just follow these steps:

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history.

[Many thanks to all of the contributors](https://github.com/whazzmaster/fitgem-client/graphs/contributors) that have
submitted pull requests to improve the examples on this site.

## Copyright

Copyright &copy; 2011-2013 Zachery Moneypenny. See LICENSE.txt for further details.
# Rater

Rater is the rails template generator. Every time rails new, i feel bored to put some gem and generate it manually. Some ruby gem like Devise, simple form and kaminari usually i used for every rails app. So I decide to setup the template use the common ruby gem into rails new command. So no need put and config manually again

## How To Use rater

To build a Rails application using the rater tool:

$ rails new myapp -m https://raw.github.com/madaarya/rater/master/rater.rb

Replace myapp with the name of your application.

The $ character indicates a shell prompt; don’t include it when you run the command.


## Gemfile

It includes application gems like:

* [Exception Notification](https://github.com/smartinez87/exception_notification) for exception notification
* [jQuery Rails](https://github.com/rails/jquery-rails) for jQuery
* [Postgres](https://github.com/ged/ruby-pg) for access to the Postgres database
* [Simple Form](https://github.com/plataformatec/simple_form) for form markup
  and style
* [Puma](https://github.com/puma/puma) to serve HTTP requests
* [Kaminari](https://github.com/amatsuda/kaminari) for paginator helper.
* [Friendly Id](https://github.com/norman/friendly_id) for create pretty URL’s.
* [Carrierwave](https://github.com/carrierwaveuploader/carrierwave) for file uploads helper.
* [Sidekiq](https://github.com/mperham/sidekiq) for background processing.
* [Slim](https://github.com/slim-template/slim-rails) for template language.
* [Devise](https://github.com/plataformatec/devise) for authentication.

And development gems like:

* [Dotenv](https://github.com/bkeepers/dotenv) for loading environment variables
* [Pry Rails](https://github.com/rweng/pry-rails) for interactively exploring
  objects
* [ByeBug](https://github.com/deivid-rodriguez/byebug) for interactively
  debugging behavior
* [Bullet](https://github.com/flyerhzm/bullet) for help to kill N+1 queries and
  unused eager loading
* [Bundler Audit](https://github.com/rubysec/bundler-audit) for scanning the
  Gemfile for insecure dependencies based on published CVEs
* [Spring](https://github.com/rails/spring) for fast Rails actions via
  pre-loading
* [Quiet Assets](https://github.com/evrone/quiet_assets) for muting assets
  pipeline log messages
* [Rails Panel](https://github.com/dejan/rails_panel) for Chrome extension that will end your tailing of
  development.log
* [Rack Mini Profiler](https://github.com/MiniProfiler/rack-mini-profiler) for profiler your 
  development Ruby rack apps.
* [Better Errors](https://github.com/charliesome/better_errors) for better error page.
* [Letter Opener web](https://github.com/fgrehm/letter_opener_web) for browsing sent emails.
* [Annotate](https://github.com/ctran/annotate_models) for comment summarizing the current schema to the top of model, fixture, etc

And testing gems like:

* [Capybara](https://github.com/jnicklas/capybara) and
  [Capybara Webkit](https://github.com/thoughtbot/capybara-webkit) for
  integration testing
* [Factory Girl](https://github.com/thoughtbot/factory_girl) for test data
* [Formulaic](https://github.com/thoughtbot/formulaic) for integration testing
  HTML forms
* [RSpec](https://github.com/rspec/rspec) for unit testing
* [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers) for common
  RSpec matchers
* [Timecop](https://github.com/ferndopolis/timecop-console) for testing time

## Spring

rater uses [spring](https://github.com/rails/spring) by default.
It makes Rails applications load faster, but it might introduce confusing issues
around stale code not being refreshed.
If you think your application is running old code, run `spring stop`.
And if you'd rather not use spring, add `DISABLE_SPRING=1` to your login file.


## Issues

If you have problems, please create a
[GitHub Issue](https://github.com/madaarya/rater/issues).

### How to Contribute

* Fork the project
* Create your feature or fix branch (`git checkout -b my-new-feature`)
* Writing new feature or fixing something
* Commit your changes (`git commit -am 'Add some feature'`)
* Push to the branch (`git push origin my-new-feature`)
* Perform a pull request in GitHub's web interface.

## License

rater is Copyright © 2016 madaarya.
It is free software,
and may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: LICENSE
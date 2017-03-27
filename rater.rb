def say_custom(tag, text); say "\033[1m\033[36m" + tag.to_s.rjust(10) + "\033[0m" + "  #{text}" end

def ask_wizard(question)
  ask "\033[1m\033[36m" + ("option").rjust(10) + "\033[1m\033[36m" + "  #{question}\033[0m"
end

def whisper_ask_wizard(question)
  ask "\033[1m\033[36m" + ("choose").rjust(10) + "\033[0m" + "  #{question}"
end

def multiple_choice(question, choices)
  say_custom('option', "\033[1m\033[36m" + "#{question}\033[0m")
  values = {}
  choices.each_with_index do |choice,i|
    values[(i + 1).to_s] = choice[1]
    say_custom( (i + 1).to_s + ')', choice[0] )
  end
  answer = whisper_ask_wizard("Enter your selection(1/2):") while !values.keys.include?(answer)
  values[answer]
end

def copy_from_repo(filename, destination)
  begin
    remove_file destination
    get "https://raw.github.com/madaarya/rater/master/files/" + filename, destination
  rescue OpenURI::HTTPError
    say_custom "Unable to obtain #{filename} from the repo, please check your connection"
  end
end

gsub_file 'Gemfile', /gem 'sqlite3'\n/, ''

database_adapter = multiple_choice "Database used in development?", [["PostgreSQL", "postgresql"], ["MySQL", "mysql2"]]

db_username = ask_wizard("Database username?")
db_password = ask_wizard("Database Password for user #{db_username}?")
locale = ask_wizard("Locale?")
user = ask_wizard("resource model for devise?")

if database_adapter == "postgresql"
  gem 'pg'
  gem 'pg_search'
else
  gem 'mysql2'
end

gem 'devise'
gem 'devise-async'
gem 'mini_magick'
gem 'carrierwave'
gem 'kaminari'
gem 'holder_rails'
gem "twitter-bootstrap-rails"
gem 'slim-rails'
gem 'dotenv-rails'
gem 'sidekiq'
gem 'redis-namespace'
gem 'redis-rails'
gem 'jquery-turbolinks'
gem 'friendly_id', '~> 5.1.0'
gem 'simple_form'
gem 'rails_admin'
gem 'devise-bootstrap-views'

gem_group :production do 
  gem 'exception_notification'
end

gem_group :development do
  gem 'byebug'
  gem 'foreman'
  gem 'pry-byebug'
  gem 'rails_best_practices'
  gem 'pry-rails'
  gem 'annotate', github: 'ctran/annotate_models'
  gem 'rack-mini-profiler', require: false
  gem 'bullet'
  gem 'meta_request'
  gem 'spring'
end

gem_group :test, :development do
  gem 'rspec-rails'
  gem 'formulaic'
  gem 'shoulda-matchers', require: false
  gem 'database_cleaner'
  gem 'timecop-console', :require => 'timecop_console'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'capybara-email' 
end

application(nil, env: "development") do<<-'RUBY'
config.action_mailer.delivery_method = :letter_opener
  config.after_initialize do
    Bullet.enable = true
    Bullet.alert = true
    Bullet.rails_logger = true
    Bullet.console = true
  end
RUBY
end

application(nil, env: "production") do<<-'RUBY'
config.middleware.use ExceptionNotification::Rack,
  :email => {
    :email_prefix         => "[#{app_name} notifier] ",
    :sender_address       => %{"notifier" <notifier@#{app_name}.com>},
    :exception_recipients => %w{your_email@gmail}
  }
RUBY
end

create_file 'Procfile', "web: bundle exec rails server \nsidekiq: bundle exec sidekiq" 

create_file '.env' do <<-FILE
# Add account credentials and API keys here.
# This file should be listed in .gitignore to keep your settings secret!
# Each entry sets a local environment variable.
# For example, setting:
# GMAIL_USERNAME=Your_Gmail_Username
# makes 'Your_Gmail_Username' available as ENV["GMAIL_USERNAME"]
SMTP_EMAIL=''
SMTP_PASSWORD=''
SIDEKIQ_REDIS_URL=''
FILE
end

inject_into_file 'app/assets/javascripts/application.js', "//= require jquery.turbolinks\n", after: "require jquery\n"
inject_into_file 'app/assets/javascripts/application.js', after: "require turbolinks\n" do
  "//= require turbolinks-compatibility\n//= require holder\n" 
end
inject_into_file 'app/assets/stylesheets/application.css', after: "require self\n" do
  "*= require devise_bootstrap_views\n" 
end

append_file ".gitignore" do<<-FILE
/config/database.yml
public/uploads
FILE
end

copy_from_repo "config/database-#{database_adapter}.yml", "config/database.yml"
copy_from_repo "config/initializers/sidekiq.rb", "config/initializers/sidekiq.rb"
copy_from_repo "config/initializers/devise_async.rb", "config/initializers/devise_async.rb"
copy_from_repo "lib/tasks/auto_annotate.rake", "lib/tasks/auto_annotate.rake"
copy_from_repo "app/assets/javascripts/turbolinks-compatibility.coffee", "app/assets/javascripts/turbolinks-compatibility.coffee"

remove_file "app/views/layouts/application.html.erb"

gsub_file "config/database.yml", /username: .*/, "username: #{db_username}"
gsub_file "config/database.yml", /password:/, "password: #{db_password}"
gsub_file "config/database.yml", /database: myapp_development/, "database: #{app_name}_development"
gsub_file "config/database.yml", /database: myapp_test/,        "database: #{app_name}_test"
gsub_file "config/database.yml", /database: myapp_production/,  "database: #{app_name}_production"

after_bundle do
  git :init
  generate 'friendly_id'
  generate 'bootstrap:install static'
  generate 'simple_form:install --bootstrap'
  generate 'bootstrap:layout application'
  generate 'kaminari:views bootstrap3'
  generate 'carrierwave_backgrounder:install'
  generate 'rails_admin:install'
  generate "devise:views:locale #{locale}" 
  generate 'rspec:install'
  generate 'devise:install'
  generate "generate devise #{user.camelcase}"
end
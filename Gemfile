source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem "factory_girl_rails"
  gem "guard"
  gem "guard-rspec"
  gem "guard-rails"
  gem "guard-spork"
  gem "rb-inotify"
  gem "capybara"
  gem "webrat"
  gem "cucumber-rails", :require => false
  gem "database_cleaner"
  gem "better_errors"
  gem "binding_of_caller"
  gem "meta_request"
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'

  gem 'compass-rails'
  gem 'bootstrap-sass'
end

gem 'jquery-rails'
gem 'devise'
gem 'cancan'
gem 'gravatar_image_tag'

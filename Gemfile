source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.1'

# Use postgresql as the database for Active Record
gem 'pg', '~> 0.17.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.1'
gem 'bootstrap-sass', '~> 3.0.2.0'
gem 'font-awesome-rails', '~> 4.0.3.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 2.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.1'

# JS Runtime
gem 'therubyracer', '~> 0.12.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 1.2' # => removed in favor of roar

# Resource-Oriented Architectures in Ruby
gem 'roar-rails', '~> 0.1.4'

# Authentication
gem 'devise', '~> 3.0.0'

# Pagination
gem 'will_paginate', '~> 3.0.5'

# Trees
gem 'ancestry', '~> 2.0.0'

# Audit AR models
gem 'paper_trail', '~> 3.0.0.rc1'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
gem 'pry', group: [ :development, :test ]

# Testing stuff
group :test do
  gem 'rspec', '~> 2.13.0'                   # specs framework
  gem 'rspec-rails', '~> 2.13.2'             # rails integration for rspec
  gem 'capybara', '~> 2.1.0'                 # integration tests
  gem 'database_cleaner', '~> 1.0.1'         # clean db state during/after tests
  gem 'factory_girl_rails', '~> 4.2'         # replacement for fixtures
  gem 'spring', '~> 0.0.10'                  # faster tests!
  gem 'guard-rspec', '~> 3.0.2'              # automatically launch specs
end

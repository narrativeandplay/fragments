source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'

# Use postgresql as the database for Active Record
gem 'pg'

group :development, :test do
  # Use RSpec for testing
  gem 'rspec-rails', '~> 3.1'

  # Use Guard to run tests automatically
  gem 'guard-rspec', '~> 4.0'
  gem 'rb-readline', require: 'readline' # Use rb-readline to deal with locked string errors in guard (using zeus), require is for rails console to work properly
  gem 'guard-rails' # For auto restarting the server

  # Use Rack-Insight for debugging
  #gem 'rack-insight', '0.5.27'
  
  # Use spring as application preloader
  gem 'spring'
  gem "spring-commands-rspec" # Spring commands for rpsec
end

group :test do
  gem 'selenium-webdriver', '~> 2.35'
  gem 'capybara', '~> 2.1'
  
  # Use database_cleaner to clean database during javascript tests
  gem 'database_cleaner', '~> 1.2'
  
  # Use launchy to auto open capybara pages for debugging
  gem 'launchy'

  # Gems needed for Guard on various platforms
  # Uncomment/Comment out the lines for the gem(s) as needed

  # OSX
  # gem 'growl', '~> 1.0'

  # Linux
  gem 'libnotify', '~> 0.8'

  # Windows
  # gem 'rb-notifu', '~> 0.0'
  # gem 'win32console', '~> 1.3'

  # Use FactoryGirl for generating data for testing
  gem 'factory_girl_rails', '~> 4.2'
end

group :development do
  # Setup basic application layout
  gem 'rails_layout'
  
  # More detailed errors
  gem 'better_errors'
  gem 'binding_of_caller' # For interactive console in page when errors occur
  
  gem 'annotate'
end

# Use pry as rails console
gem 'pry-rails'

# Use Foundation as front-end framework
gem 'foundation-rails', '~> 5.3'
gem 'foundation_rails_helper', github: 'benedictleejh/foundation_rails_helper' # Form styling in Foundation
gem 'foundation-icons-sass-rails' # Foundation Icons font

# Use Slim (http://slim-lang.com) as the rendering engine
# slim-rails is used for automatic view generation
gem 'slim-rails', '~> 3.0'

# Use kaminari for paging
gem 'kaminari', '~> 0.15'

# Fix dependency resolution errors between sprockets-rails and slim
gem 'tilt', '1.4.1'

# Use Ancestry for modelling tree data
gem 'ancestry', github: 'stefankroes/ancestry'

# Use d3-rails for data visualisation (tree)
gem 'd3-rails', '~> 3.3'

# Use ckeditor for rich text editing
gem 'ckeditor', '~> 4.0'

# Use gon to get rails variables in JS
gem 'gon', '~> 5.0'

# Use JsRoutes for named routes in JS
gem 'js-routes', '~> 1.0'

# Use PluggableJs to execute per page JS
gem "pluggable_js", "~> 2.0"

# Use browser to detect browser version
gem 'browser', '~> 0.2'

# Use devise for authentication
gem 'devise', '~> 3.1'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.0'
#gem 'sass', '~> 3.3.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# Use local_time to display times in the client's local time
gem 'local_time', '~> 1.0'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

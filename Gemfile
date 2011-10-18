source 'http://rubygems.org'



# Bundle edge Rails instead:
gem 'rails', :git => 'git://github.com/rails/rails.git', :branch => '3-1-stable'

gem 'pg'
gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'
gem 'heroku'

# For the scraper
gem 'nokogiri'

gem 'twitter-bootstrap-rails', :git => 'http://github.com/seyhunak/twitter-bootstrap-rails.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :production do
  gem 'therubyracer-heroku', '0.8.1.pre3'
end


group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end
gem "devise"

group :development do
  gem 'irbtools-more'
end
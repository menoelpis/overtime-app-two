# Overtime Application Workflow 01

## Initial Setup

- $ rails new overtime --database=postgresql
- $ git init
- $ git commit -m "Initial Commit"
- $ git remote add origin git@github.com:menoelpis/overtime.git

## Gemfile Addition

* ![add](plus.png) gem 'pg' '~> 0.18'
* ![add](plus.png) gem 'devise' '~> 4.2'
* ![add](plus.png) [group :development, :test] gem 'rspec-rails', '~> 3.0' 
* ![add](plus.png) [group :development, :test] gem 'capybara', '~> 2.8' 
* ![add](plus.png) [group :development, :test] gem 'database_cleaner', '~> 1.5' 

# Rspec Installation

- $ rails generate rspec:install
- ![sub](minus.png) delete test folder
- ![add](plus.png) [spec/rails_helper.rb] 
```ruby	
	
	ENV['RAILS_ENV'] ||= 'test'
  require File.expand_path('../../config/environment', __FILE__)

  abort("The Rails environment is running in production mode!") if 
  Rails.env.production?
 	require 'spec_helper'
	require 'rspec/rails'
	require 'capybara/rails'

  ActiveRecord::Migration.maintain_test_schema!

	RSpec.configure do |config|
	  config.fixture_path = "#{::Rails.root}/spec/fixtures"
	  config.use_transactional_fixtures = false
	  config.before(:suite) { DatabaseCleaner.clean_with(:truncation) }
	  config.before(:each) { DatabaseCleaner.strategy = :transaction }
	  config.before(:each, :js => true) { DatabaseCleaner.strategy = :truncation }
	  config.before(:each) { DatabaseCleaner.start }
	  config.before(:each) { DatabaseCleaner.clean }
	  config.infer_spec_type_from_file_location!
	  config.filter_rails_from_backtrace!
	end

```

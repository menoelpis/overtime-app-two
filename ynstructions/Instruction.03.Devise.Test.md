# Overtime Application Workflow 03

## Devise Setup and Test

- $ rails generate devise:install
- ![edit](edit.png) [config/environments/development.rb]
```ruby
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
```
- $ rails generate devise:views
- ![edit](edit.png) [config/initializers/devise.rb]
```ruby
config.mailer_sender = 'no-reply@abideinhope.net'
```
- $ rails g devise User first_name:string last_name:string type:string
- $ rails db:migrate
- $ rails server [localhost:3000/users/sign_up -> Signup Process]
- $ rails console [type User.last]

## FactoryGirl Gem

- ![add](plus.png) [group :development, :test] gem 'factory_girl_rails', '~> 4.7'
- $ bundle
- ![edit](edit.png) [spec/rails_helper.rb]
```ruby
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rails'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
	config.include Warden::Test::Helpers
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.before(:suite) { DatabaseCleaner.clean_with(:truncation) }
  config.before(:each) { DatabaseCleaner.strategy = :transaction }
  config.before(:each, :js => true) { DatabaseCleaner.strategy = :truncation }
  config.before(:each) { DatabaseCleaner.start }
  config.after(:each) { DatabaseCleaner.clean }
  config.after(:each) { Warden.test_reset! }
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryGirl::Syntax::Methods
end
```

- $ mkdir spec/factories
- $ touch spec/factories/users.rb
- ![add](plus.png) [spec/factories/users.rb]
```ruby
FactoryGirl.define do 

	factory :user do
		email 'test@test.com'
		first_name 'Daniel'
		last_name 'Park'
		password 'asdfasdf'
		password_confirmation 'asdfasdf'
	end

end
```
- ![edit](edit.png) [spec/model/user_spec.rb]
```ruby
require 'rails_helper'

RSpec.describe User, type: :model do

  before do
  	@user = FactoryGirl.create(:user)
  end

  describe "creation" do
  	it "can be created" do
  		expect(@user).to be_valid
  	end

  	it "cannot be created without first_name, last_name" do
  		@user.first_name = nil
  		@user.last_name = nil
  		expect(@user).to_not be_valid
  	end
  end

end
```
- ![add](plus.png) [app/models/user.rb]
```ruby
validates_presence_of :first_name, :last_name
```

- $ rspec [which will result in success!]
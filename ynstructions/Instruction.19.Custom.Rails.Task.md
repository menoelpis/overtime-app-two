# Overtime Application Workflow 19

## Creating a Custom Rails Task

- $ rails -T [which shows all tasks]
- $ rails g task notification sms

- ![edit](edit.png) [lib/tasks/notification.rake]
```rake
namespace :notification do
  desc "Sends SMS notification to employees asking them to log if they had overtime or not"   <<<
  task sms: :environment do
  	puts "I'm in a rake task"   <<<
  end
end
```

- $ rails -T [check if there is notification task]
- $ rails notification:sms [check the text output]

- $ rails g migration add_phone_to_users phone:string
- $ rails db:migrate

### Find all User.create method and User factory in all files
### Add phone field with some data

### Edit User Model Spec by Adding Phone
- ![edit](edit.png) [spec/models/user_spec.rb]
```rb
.
.
.
it "cannot be created without first_name" do
	@user.first_name = nil
	expect(@user).to_not be_valid
end

it "cannot be created without last_name" do
  @user.last_name = nil
  expect(@user).to_not be_valid
end

it "cannot be created without phone" do
  @user.phone = nil
  expect(@user).to_not be_valid
end
.
.
.
```

- ![edit](edit.png) [app/models/user.rb]
```rb
.
.
.
validates_presence_of :first_name, :last_name, :phone   <<<
.
.
.
```
 - $ rspec [which will pass!]

 ### Modify Dashboard
 - ![edit](edit.png) [app/dashboards/user_dashboard.rb]
 ```rb
 require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
  	.
  	.
  	.
    type: Field::String.with_options(searchable: false),
    phone: Field::String.with_options(searchable: false),   <<<
    created_at: Field::DateTime.with_options(searchable: false),
    updated_at: Field::DateTime.with_options(searchable: false),
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :posts,
    :email,
    :type,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :posts,
    :email,
    :phone,   <<<
    .
    .
    .
  ].freeze

  FORM_ATTRIBUTES = [
    :email,
    :password,
    :first_name,
    :last_name,
    :phone,   <<<
  ].freeze
end
```

- ![edit](edit.png) [app/dashboards/admin_user_dashboard.rb]
```rb
require "administrate/base_dashboard"

class AdminUserDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
  	.
  	.
  	.
    type: Field::String.with_options(searchable: false),
    phone: Field::String.with_options(searchable: false),   <<<
    created_at: Field::DateTime.with_options(searchable: false),
    updated_at: Field::DateTime.with_options(searchable: false),
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :posts,
    :id,
    :email,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :posts,
    :id,
    :email,
    :phone,   <<<
    .
    .
    .
  ].freeze

  FORM_ATTRIBUTES = [
    :email,
    :password,
    :first_name,
    :last_name,
    :type,
    :phone,   <<<
  ].freeze

end
```


- ![edit](edit.png) [spec/models/user_spec.rb]
```rb
require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryGirl.create(:user)
  end

  describe "creation" do   <<<
    it "can be created" do
      expect(@user).to be_valid
    end
  end

  describe "validation" do   <<<
    it "cannot be created without first_name" do
      @user.first_name = nil
      expect(@user).to_not be_valid
    end

    it "cannot be created without last_name" do
      @user.last_name = nil
      expect(@user).to_not be_valid
    end

    it "cannot be created without phone" do
      @user.phone = nil
      expect(@user).to_not be_valid
    end

    it 'requires the phone attr to only contain integers' do
      @user.phone = 'mygreatstr'
      expect(@user).to_not be_valid
    end

    it 'requires the phone attr to only have 10 chars' do
      @user.phone = '12345678901'
      expect(@user).to_not be_valid
    end
  end
  .
  .
  .
end
```


- ![add](plus.png) [app/models/user.rb]
```rb
class User < ApplicationRecord
.
.
.
PHONE_REGEX = /\A[0-9]*\Z/
validates_format_of :phone, with: PHONE_REGEX
validates :phone, length: { is: 10 }
.
.
.
```

- ![edit](edit.png) [lib/sms_tool.rb]
```rb
module SmsTool
  account_sid = ENV['TWILIO_ACCOUNT_SID'] 
  auth_token = ENV['TWILIO_AUTH_TOKEN'] 

  @client = Twilio::REST::Client.new account_sid, auth_token 

  def self.send_sms(number:, message:)
    @client.messages.create(
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: "+82#{number}",
      body: "#{message}"
    )
  end
end
```

- $ rails c
- >> SmsTool.send_sms(number: '1076580774', message: "Look at me, I'm in a text!")

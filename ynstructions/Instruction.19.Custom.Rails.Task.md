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
    posts: Field::HasMany.with_options(searchable: false),
    id: Field::Number.with_options(searchable: false),
    email: Field::String.with_options(searchable: true),
    password: Field::String.with_options(searchable: false),
    sign_in_count: Field::Number.with_options(searchable: false),
    current_sign_in_at: Field::DateTime.with_options(searchable: false),
    last_sign_in_at: Field::DateTime.with_options(searchable: false),
    current_sign_in_ip: Field::String.with_options(searchable: false),
    last_sign_in_ip: Field::String.with_options(searchable: false),
    first_name: Field::String.with_options(searchable: false),
    last_name: Field::String.with_options(searchable: false),
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

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :posts,
    :email,
    :phone,   <<<
    :sign_in_count,
    :current_sign_in_at,
    :last_sign_in_at,
    :current_sign_in_ip,
    :last_sign_in_ip,
    :first_name,
    :last_name,
    :type,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
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
    posts: Field::HasMany.with_options(searchable: false),
    id: Field::Number.with_options(searchable: false),
    email: Field::String.with_options(searchable: true),
    password: Field::String.with_options(searchable: false),
    sign_in_count: Field::Number.with_options(searchable: false),
    current_sign_in_at: Field::DateTime.with_options(searchable: false),
    last_sign_in_at: Field::DateTime.with_options(searchable: false),
    current_sign_in_ip: Field::String.with_options(searchable: false),
    last_sign_in_ip: Field::String.with_options(searchable: false),
    first_name: Field::String.with_options(searchable: false),
    last_name: Field::String.with_options(searchable: false),
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
    :sign_in_count,
    :current_sign_in_at,
    :last_sign_in_at,
    :current_sign_in_ip,
    :last_sign_in_ip,
    :first_name,
    :last_name,
    :type,
    :created_at,
    :updated_at,
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


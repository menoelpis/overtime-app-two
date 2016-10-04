# Overtime Application Workflow 11

## Approval Workflow for Posts

- $ rails g migration add_status_to_posts status:integer

- ![edit](edit.png) [db/migrate/*_add_status_to_posts.rb]
```rb
class AddStatusToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :status, :integer, default: 0   <<<
  end
end
```

- $ rails db:migrate

- ![edit](edit.png) [app/models/post.rb]
```rb
class Post < ApplicationRecord
	enum status: { submitted: 0, approved: 1, rejected: 2 }   <<<
	belongs_to :user
	validates_presence_of :date, :rationale
end
```

- $ rails db:setup [database reset]
- $ rails c --sandbox [check status enum in console sandbox]
```rb
>> Post.submitted.count
>> Post.last.approved!
>> Post.approved.count 
```

- ![add](plus.png) [db/seeds.rb]
```rb
.
.
.
AdminUser.create(email: "admin@test.com", password: "asdfasdf", password_confirmation: "asdfasdf", first_name: "Admin", last_name: "Park")

puts "1 admin user created"
.
.
.
```

- ![edit](edit.png) [app/controllers/dashboards/admin_user.dashboard.rb] *modify admin user dashboard to show status*
```rb
require "administrate/base_dashboard"

class PostDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    .
    .
    .
    updated_at: Field::DateTime.with_options(searchable: false),
    status: Field::Text.with_options(searchable: true),   <<<
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :user,
    :status,   <<<
    :date,
    :rationale,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :user,
    :status,   <<<
    .
    .
    .
  ].freeze
  .
  .
  .
end
```
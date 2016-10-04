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
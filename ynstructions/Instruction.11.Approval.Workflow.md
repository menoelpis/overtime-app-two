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

- $ touch spec/features/approval_workflow_spec.rb

- ![add](plus.png) [spec/features/approval_workflow_spec.rb]
```rb
require 'rails_helper'

describe 'navigate' do
	before do
		@admin_user = FactoryGirl.create(:admin_user)
		login_as(@admin_user, :scope => :user)
	end

	describe 'edit' do 
		before do
			@post = FactoryGirl.create(:post)
		end

		it 'has a status that can be edited on the form' do 
			visit edit_post_path(@post)

			choose('post_status_approved')
			click_on "Save"

			expect(@post.reload.status).to eq('approved')
		end
	end
end
```

- ![add](plus.png) [app/views/_form.html.erb]
```erb
<%= form_for @post, class: "form-horizontal" do |f| %>

	.
	.
	.

  <div class="form-group">
    <%= f.label :rationale, class: "col-sm-2 control-label" %>
    <%= f.text_area :rationale, class: "form-control" %>
  </div>

  <div class="form-group">   <<<
    <%= f.radio_button :status, 'submitted' %>
    <%= f.label :status, 'Submitted' %>

    <%= f.radio_button :status, 'approved' %>
    <%= f.label :status, 'Approved' %>

    <%= f.radio_button :status, 'rejected' %>
    <%= f.label :status, 'Rejected' %>
  </div>

  <%= f.submit 'Save', class: 'btn btn-primary btn-block' %>

<% end %>
```

- ![edit](edit.png) [app/controllers/posts_controller.rb] *add status to param permit section*
```rb
class PostsController < ApplicationController
	.
	.
	.

	private

		def post_params
			params.require(:post).permit(:date, :rationale, :status)   <<<
		end

		def set_post
			@post = Post.find(params[:id])
		end
end
```

- $ rspec [which will succeed]

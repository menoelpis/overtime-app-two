# Overtime Application Workflow 16

## Adding Overtime Hours to Posts with Validations

- $ rails g migration add_post_hour_request_to_posts overtime_request:decimal

- ![edit](edit.png) [db/migrate/*_add_post_hour_request_to_posts.rb]
```rb
class AddPostHourRequestToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :overtime_request, :decimal, default: 0.0   <<<
  end
end
```

- $ rails db:migrate

## Find Post.create Method and Insert [overtime_request: some decimal value] in all the files
## Insert [overtime_request: some value] into Factories/Posts
## Insert [:overtime_request] into Post Model Presence Validation Method

- ![add](plus.png) [spec/models/post_spec.rb]
```rb
require 'rails_helper'
		.
		.
		.
  	it 'cannot be created without a date, rationale and overtime_request' do   <<<
  		@post.date = nil
  		@post.rationale = nil
      @post.overtime_request = nil   <<<
  		expect(@post).to_not be_valid
  	end

    it 'has an overtime_request greater than 0.0' do   <<<
      @post.overtime_request = 0.0
      byebug
    end
  end

end
```

- $ rspec spec/models/post_spec.rb
```rb
..Return value is: nil

[20, 29] in /root/dev/overtime-app-kali/spec/models/post_spec.rb
   20:   		expect(@post).to_not be_valid
   21:   	end
   22: 
   23:     it 'has an overtime_request greater than 0.0' do
   24:       @post.overtime_request = 0.0
   25:       byebug
=> 26:     end
   27:   end
   28: 
   29: end
   (byebug) @post.overtime_request.to_f   <<<
```

- ![edit](edit.png) [spec/models/post_spec.rb]
```rb
require 'rails_helper'
		.
		.
		.
  	it 'cannot be created without a date, rationale and overtime_request' do   <<<
  		@post.date = nil
  		@post.rationale = nil
      @post.overtime_request = nil   <<<
  		expect(@post).to_not be_valid
  	end

    it 'has an overtime_request greater than 0.0' do   <<<
      @post.overtime_request = 0.0
      expect(@post).to_not be_valid
    end
  end

end
```

- $ rspec spec/modesl/post_spec.rb [which will fail!]

- ![add](plus.png) [app/models/post.rb]
```rb
class Post < ApplicationRecord
	enum status: { submitted: 0, approved: 1, rejected: 2 }
	belongs_to :user
	validates_presence_of :date, :rationale, :overtime_request

	validates :overtime_request, numericality: { greater_than: 0.0 }   <<<

	scope :posts_by, ->(user) { where(user_id: user.id) }
end
```

- $ rspec [which will fail!]

## Fix the errors

- ![edit](edit.png) [spec/features/post_spec.rb]
```rb
it 'can be created from new form page' do
	fill_in 'post[date]', with: Date.today
	fill_in 'post[rationale]', with: "Some Rationale"
	fill_in 'post[overtime_request]', with:4.5   <<<

	expect { click_on "Save" }.to change(Post, :count).by(1)   <<<
end

it 'will have a user associated with it' do
	fill_in 'post[date]', with: Date.today
	fill_in 'post[rationale]', with: "User Association"
	fill_in 'post[overtime_request]', with: 4.5   <<<
	click_on "Save"

	expect(User.last.posts.last.rationale).to eq("User Association")
end
```

- ![edit](edit.png) [app/controllers/posts_controller.rb]
```rb
.
.
.
def post_params
	params.require(:post).permit(:date, :rationale, :status, :overtime_request)   <<<
end
.
.
.
```

- ![edit](edit.png) [app/views/posts/_form.html.erb]
```erb
<%= form_for @post, class: "form-horizontal" do |f| %>

	<% if @post.errors.any? %>
		<% @post.errors.full_messages.each do |error| %>
		  <%= js add_gritter(error, title: "Overtime App Notification", sticky: false) %>
		 <% end %>
	<% end %>

  <div class="form-group">   <<<
    <%= f.label :overtime_request, class: "col-sm-2 control-label" %>
    <%= f.text_field :overtime_request, class: "form-control" %>
  </div>
  .
  .
  .
<% end %>
```

- $ rails db:setup

## Add overtime hour section to the pages

- ![edit](edit.png) [app/views/posts/index.html.erb]
```erb
<h1>Posts Index</h1>
  .
  .
  .
  <th>
    #
  </th>
  <th>
    Overtime Requested   <<<
  </th>
  .
  .
  .
```

- ![edit](edit.png) [app/views/posts/_post.html.erb]
```erb
<tr>
  <td>
    <%= post.id %>
  </td>
  <td>
    <%= post.overtime_request %>   <<<
  </td>
  .
  .
  .
```
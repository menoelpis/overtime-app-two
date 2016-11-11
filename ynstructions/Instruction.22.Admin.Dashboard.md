# Overtime Application Workflow 22

## Building out a Monitoring Dashboard for Managers

- $ touch app/views/static/_employee.html.erb
- $ touch app/views/static/_admin.html.erb

- ![add](plus.png) [app/helpers/application_helper.rb]
```rb
module ApplicationHelper
	def admin_types   <<<
		['AdminUser']
	end
	.
	.
	.
end
```

- ![edit](edit.png) [app/views/static/homepage.html.erb]
```rb
<% if admin_types.include?(current_user.try(:type)) %>
	<%= render 'admin' %>
<% else %>
	<%= render 'employee' %>
<% end %>
```

- $ touch app/assets/stylesheets/admin_homepage.css
- ![add](plus.png) [app/assets/stylesheets/admin_homepage.css]
```css
.pending-homepage {
	margin-top: 20px;
	margin-bottom: 20px;
	background-color: #E3E3E3;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	border-radius: 3px;
	padding: 20px;
}

.homepage-block {
	background-color: #1D3C91;
	color: white;
	margin: 12px 42px 12px 42px;
	padding: 15px;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	border-radius: 3px;
}

.pending-details {
	font-weight: 900;
}
```

- ![add](plus.png) [app/assets/stylesheets/application.css.scss]
```scss
.
.
.
@import "bourbon";
@import "admin_homepage.css";   <<<
.
.
.
```

- ![add](plus.png) [app/controllers/static_controller.rb]
```rb
class StaticController < ApplicationController
	def homepage
		@pending_approvals = Post.where(status: 'submitted')   <<<
	end
end
```

- ![edit](edit.png) [app/views/static/_admin.html.erb]
```erb
<div class="container-fluid">
	<div class="pending-homepage row">
		<h2>Items Pending Your Approval</h2>
		<hr>
		<%= render partial: 'pending_approval', locals: { pending_approvals: @pending_approvals } %>
	</div>
</div>

<div class="pending-homepage">
	<div>
		<p>asdf</p>
	</div>
</div>
```

- $ touch app/views/static/_pending_approval.html.erb
- ![add](plus.png) [app/views/static/_pending_approval.html.erb]
```erb
<% @pending_approvals.each do |pending_approval| %>
	<div class="homepage-block col-md-3">
		<h4><%= pending_approval.user.full_name %></h4>
		<p>
			<span class="pending-details">Date Submitted:</span> <%= pending_approval.date %>
		</p>
		<p>
			<span class="pending-details">Rationale:</span> <%= truncate pending_approval.rationale, length: 48 %>
		</p>
		<div class="row">
			<div class="col-md-6 column">
				<%= link_to 'Approve', root_path, class: 'btn btn-success btn-block', id: "approve_#{pending_approval.id}" %>
			</div>
			<div class="col-md-6 column">
				<%= link_to 'Review', edit_post_path(pending_approval), class: 'btn btn-warning btn-block' %>
			</div>
		</div>

	</div>
<% end %>
```

- ![edit](edit.png) [app/views/static/_employee.html.erb]
```erb
<h1>Hi Employee!</h1>
```

- $ rails s [check homepage for both type of user]

- $ touch spec/features/homepage_spec.rb
- ![add](plus.png) [spec/features/homepage_spec.rb]
```rb
require 'rails_helper'

describe 'Homepage' do
	it 'allows the admin to approve posts from the homepage' do
		post = FactoryGirl.create(:post)
		admin_user = FactoryGirl.create(:admin_user)
		login_as(admin_user, :scope => :user)

		visit root_path

		click_on("approve_#{post.id}")

		expect(post.reload.status).to eq('approved')
	end
end
```

- $ rspec spec/features/homepage_spec.rb [which will fail!]

- ![edit](edit.png) [config/routes.rb]
```rb
Rails.application.routes.draw do
  resources :audit_logs, except: [:new, :edit, :destroy]
  .
  .
  .
  resources :posts do   <<<
    member do
      get :approve
    end
  end
  devise_for :users, skip: [:registrations]
  root to: 'static#homepage'
end
```

- $ rails routes | grep approve [which will show the approve route]

- ![add](plus.png) [app/controllers/posts_controller.rb]
```rb
class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy, :approve]   <<<

	def index
		@posts = Post.posts_by(current_user).page(params[:page]).per(10)
	end

	def approve   <<<
		authorize @post
		@post.approved!
		redirect_to root_path, notice: "The post has been approved"
	end
	.
	.
	.
end
```

- ![add](plus.png) [app/policies/post_policy.rb]
```rb
class PostPolicy < ApplicationPolicy
	def update?
		return true if post_approved? && admin?
		return true if user_or_admin && !post_approved?
	end	

	def approve?
		admin?
	end
	.
	.
	.
```

- ![edit](edit.png) [app/views/static/_pending_approval.html.erb]
```erb
.
.
.
<div class="col-md-6 column">
	<%= link_to 'Approve', approve_post_path(pending_approval), class: 'btn btn-success btn-block', id: "approve_#{pending_approval.id}" %>   <<<
</div>
.
.
.
```

- $ rspec [which will succeed!]

- ![edit](edit.png) [app/views/static/_admin.html.erb]
```rb
<div class="container-fluid">
	<div class="pending-homepage row">
		<h2>Items Pending Your Approval</h2>
		<hr>
		<%= render partial: 'pending_approval', locals: { pending_approvals: @pending_approvals } %>
	</div>

	<div class="pending-homepage row">
		<h2>Confirmation Log</h2>
		<hr>
		<%= render partial: 'confirmation_log', locals: { recent_audit_items: @recent_audit_items } %>
		<div class="clearfix"></div>
		<hr>
		<%= link_to 'View All Items', audit_logs_path, class: 'btn btn-primary' %>
	</div>
</div>
```

- ![add](plus.png) [app/controllers/static_controller.rb]
```rb
class StaticController < ApplicationController
	def homepage
		@pending_approvals = Post.where(status: 'submitted')
		@recent_audit_items = AuditLog.last(10)
	end
end
```

- $ touch app/views/static/_confirmation_log.html.erb
- ![add](plus.png) [app/views/static/_confirmation_log.html.erb]
```rb
<% @recent_audit_items.each do |recent_audit_item| %>
	<div class="homepage-block col-md-3">
		<h4><%= recent_audit_item.user.full_name %></h4>
		<p>
			<span class="pending-details">Week starting:</span> <%= recent_audit_item.start_date %>
		</p>
		<p>
			<span class="pending-details">Confirmed at:</span> <%= recent_audit_item.end_date || status_label('pending') %>
		</p>
		<p>
			<span class="pending-details">Status:</span> <%= status_label recent_audit_item.status %>
		</p>
	</div>
<% end %>
```

- ![add](plus.png) [app/assets/stylesheets/admin_homepage.css] * hover effect on the block
```css
.
.
.
.homepage-block:hover {
	background-color: #172b63;
}
```
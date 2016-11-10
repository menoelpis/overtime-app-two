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
				<%= link_to 'Approve', root_path, class: 'btn btn-success btn-block' %>
			</div>
			<div class="col-md-6 column">
				<%= link_to 'Review', root_path, class: 'btn btn-warning btn-block' %>
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
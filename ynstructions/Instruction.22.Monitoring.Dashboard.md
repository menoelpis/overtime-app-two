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
	margin: 15px;
	padding: 15px;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	border-radius: 3px;
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

- ![edit](edit.png) [app/views/static/_admin.html.erb]
```erb
<div class="container-fluid">
	<div class="pending-homepage row">
		<div class="homepage-block col-md-3">
			<p>asdf</p>
		</div>
			<div class="homepage-block col-md-3">
			<p>asdf</p>
		</div>
			<div class="homepage-block col-md-3">
			<p>asdf</p>
		</div>
	</div>
</div>

<div class="pending-homepage">
	<div>
		<p>asdf</p>
	</div>
</div>
```

- ![edit](edit.png) [app/views/static/_employee.html.erb]
```erb
<h1>Hi Employee!</h1>
```

- $ rails s [check homepage for both type of user]
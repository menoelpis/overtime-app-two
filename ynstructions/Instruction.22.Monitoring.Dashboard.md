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

- ![edit](edit.png) [app/views/static/_admin.html.erb]
```erb
<h1>Hi Admin!</h1>
```

- ![edit](edit.png) [app/views/static/_employee.html.erb]
```erb
<h1>Hi Employee!</h1>
```

- $ rails s [check homepage for both type of user]
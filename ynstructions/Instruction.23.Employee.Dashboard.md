# Overtime Application Workflow 23

## Building out a Monitoring Dashboard for Employees

- ![add](plus.png) [app/controllers/application_controller.rb]
```rb
	.
	.
	.
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def admin_types   <<<
  	['AdminUser']
  end
  .
  .
  .
```

- ![edit](edit.png) [app/controllers/static_controller.rb]
```rb
class StaticController < ApplicationController
	def homepage
		if admin_types.include?(current_user.type)
			@pending_approvals = Post.submitted
			@recent_audit_items = AuditLog.last(10)
		else
			#something else
		end
	end
end
```

- $ touch app/assets/stylesheets/employee_homepage.css

- ![add](plus.png) [app/assets/stylesheets/application.css.scss]
```scss
.
.
.
@import "admin_homepage.css";
@import "employee_homepage.css";   <<<
.
.
.
```


- ![edit](edit.png) [app/views/static/_employee.html.erb]
```erb
<div class="container-fluid">
	<div class="row">
		<div class="col-md-5 column jumbotron employee-blocks">
			example 1
		</div>
		<div class="col-md-5 column jumbotron employee-blocks">
			example 2
		</div>
	</div>
</div>
```


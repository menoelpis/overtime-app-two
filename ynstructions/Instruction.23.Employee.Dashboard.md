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
			@pending_audit_confirmations = current_user.audit_logs
		end
	end
end
```

- $ touch app/assets/stylesheets/employee_homepage.css
- ![add](plus.png) [app/assets/stylesheets/employee_homepage.css]
```css
.employee-blocks {
	margin-top: 45px;
	margin-bottom: 45px;
}
```

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
		<div class="pending-homepage employee-blocks">
			<h3>Pending Your Confirmation</h3>
			<%= render partial: 'pending_audit_confirmations', locals: { pending_audit_confirmations: @pending_audit_confirmations } %>
		</div>
		<div class="col-md-5 column pending-homepage employee-blocks">
			example 1
		</div>
	</div>
</div>
```

- $ touch app/views/static/_pending_audit_confirmations.html.erb
- ![add](plus.png) [app/views/static/_pending_audit_confirmations.html.erb]
```erb
<% pending_audit_confirmations.each do |pending_audit_confirmation| %>
	<%= link_to "I confirm that I did not perform any overtime for the week of: #{pending_audit_confirmation.start_date}", root_path, class: 'btn btn-primary btn-block btn-lg', data: { confirm: 'Are you sure to confirm that you did not perform any overtime?' } %>
<% end %>
```

- ![edit](edit.png) [db/seeds.rb]
```rb
.
.
.
puts "100 posts have been created!"

AuditLog.create!(user_id: @user.id, status: 0, start_date: (Date.today - 6.days))   <<<
AuditLog.create!(user_id: @user.id, status: 0, start_date: (Date.today - 13.days))
AuditLog.create!(user_id: @user.id, status: 0, start_date: (Date.today - 20.days))

puts "3 audit logs have been created"
```

- $ rails db:setup
- $ rails s [check user account]






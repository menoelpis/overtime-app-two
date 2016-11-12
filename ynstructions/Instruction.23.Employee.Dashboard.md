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
	<%= link_to "I confirm that I did not perform any overtime for the week of: #{pending_audit_confirmation.start_date}", root_path, class: 'btn btn-primary btn-block btn-lg', id: "confirm_#{pending_audit_confirmation.id}", data: { confirm: 'Are you sure to confirm that you did not perform any overtime?' } %>
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

- ![add](plus.png) [spec/features/homepage_spec.rb]
```rb
require 'rails_helper'

describe 'Homepage' do
	.
	.
	.
	it 'allows the employee to change the audit log status from the homepage' do
		audit_log = FactoryGirl.create(:audit_log)
		user = FactoryGirl.create(:user)
		login_as(user, :scope => :user)

		audit_log.update(user_id: user.id)

		visit root_path

		click_on("confirm_#{audit_log.id}")

		expect(audit_log.reload.status).to eq('confirmed')
	end
```

-$ rspec spec/features/homepage_spec.rb [which will fail!]

- ![edit](edit.png) [config/routes.rb]
```rb
Rails.application.routes.draw do
  resources :audit_logs, except: [:new, :edit, :destroy] do   <<<
    member do
      get :confirm
    end
  end
  .
  .
  .
end
```

- ![add](plus.png) [app/controllers/audit_logs_controller.rb]
```rb
class AuditLogsController < ApplicationController
	.
	.
	.
	def confirm   <<<
		audit_log = AuditLog.find(params[:id])
		authorize audit_log
		audit_log.confirmed!
		redirect_to root_path, notice: "Thank you, your confirmation has been successfully made."
	end
end
```

- ![add](plus.png) [app/policies/audit_log_policy.rb]
```rb
class AuditLogPolicy < ApplicationPolicy
	def index?
		# TODO Refactor
		return true if admin?
	end	

	def confirm?   <<<
		record.user_id == user.id
	end

	private 

		def admin?
			admin_types.include?(user.type)
		end
end
```

- ![edit](edit.png) [app/views/static/_pending_audit_confirmations.html.erb]
```erb
<% pending_audit_confirmations.each do |pending_audit_confirmation| %>
	<%= link_to "I confirm that I did not perform any overtime for the week of: #{pending_audit_confirmation.start_date}", confirm_audit_log_path(pending_audit_confirmation), class: 'btn btn-primary btn-block btn-lg', id: "confirm_#{pending_audit_confirmation.id}", data: { confirm: 'Are you sure to confirm that you did not perform any overtime?' } %>
<% end %>
```

- ![edit](edit.png) [app/controllers/static_controller.rb]
```rb
class StaticController < ApplicationController
	def homepage
		if admin_types.include?(current_user.type)
			@pending_approvals = Post.submitted
			@recent_audit_items = AuditLog.last(10)
		else
			@pending_audit_confirmations = current_user.audit_logs.pending   <<<
		end
	end
end
```

- ![edit](edit.png) [app/views/static/_employee.html.erb]
```erb
<div class="container-fluid">
	<div class="row">
		<% if @pending_audit_confirmations.count > 0 %>   <<<
			<div class="pending-homepage employee-blocks">
				<h3>Pending Your Confirmation</h3>
				<%= render partial: 'pending_audit_confirmations', locals: { pending_audit_confirmations: @pending_audit_confirmations } %>
			</div>
		<% end %>
		<div class="pending-homepage employee-blocks">   <<<
			<h3>Request Overtime</h3>
			<%= link_to "Request Overtime Approval", new_post_path, class: 'btn btn-primary btn-block btn-lg' %>
		</div>
	</div>
</div>
```





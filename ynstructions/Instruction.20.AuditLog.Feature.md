# Overtime Application Workflow 20

## Building the Audit Log Functionality

- Goal of audit log:
- Keep track of if a employee had overtime or not
- Dependencies: User
- Attrs: 
* Status:integer(enum) -> pending, complete
* start_date:date -> default previous Monday
* date_verified

Monday
|
|
|
Sunday ---- notification

- $ rails g resource AuditLog user:references status:integer start_date:date end_date:date

![edit](edit.png) [db/migrate/*_create_audit_logs.rb]
```rb
class CreateAuditLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :audit_logs do |t|
      t.references :user, foreign_key: true
      t.integer :status, default: 0   <<<
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
```

- $ rails db:migrate

![edit](edit.png) [app/models/user.rb]
```rb
class User < ApplicationRecord
	has_many :posts
  has_many :audit_logs   <<<
  .
  .
  .
end
```

- $ rails c --sandbox
- >> AudigLog.create(user_id: User.last.id)
- >> User.last.audit_logs
- >> AuditLog.last.user.full_name

- ![add](plus.png) [db/seeds.rb]
```rb
.
.
.
100.times do |audit_log|
	AuditLog.create!(user_id: @user.id, status: 0, start_date: (Date.today - 6.days))
end

puts "100 audit logs have been created"
```

- $ rails db:setup
- $ rails c -e test
- >> FactoryGirl.create(:user)
- >> FactoryGirl.create(:audit_log)

![edit](edit.png) [spec/models/audit_log_spec.rb]
```rb
require 'rails_helper'

RSpec.describe AuditLog, type: :model do
	before do
		@audit_log = FactoryGirl.create(:audit_log)
	end

	describe 'creation' do
		it 'can be properly created' do
			expect(@audit_log).to be_valid
		end
	end

	describe 'validations' do
		it 'it should be required to have a user association' do
			@audit_log.user_id = nil
			expect(@audit_log).to_not be_valid
		end

		it 'it should always have a status' do
			@audit_log.status = nil
			expect(@audit_log).to_not be_valid
		end

		it 'it should be required to have a start_date' do
			@audit_log.start_date = nil
			expect(@audit_log).to_not be_valid
		end

		it 'it should have a start date equal to 6 days prior' do
			new_audit_log = AuditLog.create(user_id: User.last.id)
			expect(new_audit_log.start_date).to eq(Date.today - 6.days)
		end
	end
end
```

- ![add](plus.png) [app/models/audit_log.rb]
```rb
class AuditLog < ApplicationRecord
  belongs_to :user
  validates_presence_of :user_id, :status, :start_date
  after_initialize :set_defaults

  private
  	def set_defaults
  		self.start_date ||= Date.today - 6.days
  	end
end
```

- $ rspec spec/models/audit_log_spec.rb [which will succeed!]
- $ rails c --sandbox
- >> AuditLog.create(user_id: User.last.id) [Check if start_date is set]

- $ touch app/views/shared/_audit_log_tab.html.erb
- ![add](plus.png) [app/views/shared/_audit_log_tab.html.erb]
```erb
<li class="<%= active?(audit_logs_path) %>">
	<%= link_to "Audit Log", audit_logs_path %>
</li>
```

- ![add](plus.png) [app/views/shared/_nav.html.erb]
```erb
.
.
.
<li class="<%= active?(posts_path) %>">
	<%= link_to "Time Entries", posts_path %>
</li>

<!-- TODO: possibly refactor -->   <<<
<%= render 'shared/audit_log_tab' if policy(AuditLog).index? %>

<li class="<%= active?(new_post_path) %>">
	<%= link_to "Add New Entry", new_post_path, id: 'new_post_from_nav' %>
</li>
.
.
.
```

- $ touch app/policies/audit_log_policy.rb
- ![add](plus.png) [app/policies/audit_log_policy.rb]
```rb
class AuditLogPolicy < ApplicationPolicy
	def index?
		return true if admin?
	end	

	private 

		def admin?
			admin_types.include?(user.type)
		end
end
```

- $ touch spec/features/audit_log_spec.rb
- ![add](plus.png) [spec/features/audit_log_spec.rb]
```rb
require 'rails_helper'

describe 'AuditLog Feature' do
	let(:audit_log) { FactoryGirl.create(:audit_log) }

	describe 'index' do
		it 'has an index page that can be reached' do
			visit audit_logs_path
			expect(page.status_code).to eq(200)
		end
	end
end
```

- ![edit](edit.png) [config/routes.rb]
```rb
Rails.application.routes.draw do
  resources :audit_logs, except: [:new, :edit, :destroy]   <<<
  .
  .
  .
end
```

- ![add](plus.png) [app/controllers/audit_logs_controller.rb]
```rb
class AuditLogsController < ApplicationController
	def index   <<<
	end
end
```

- $ touch app/views/audit_logs/index.html.erb

- $ rspec spec/features/audit_log_spec.rb [which will succeed!]

- ![edit](edit.png) [spec/features/audit_log_spec.rb]
```rb
require 'rails_helper'

describe 'AuditLog Feature' do
	describe 'index' do
		before do
			admin_user = FactoryGirl.create(:admin_user)
			login_as(admin_user, :scope => :user)
			FactoryGirl.create(:audit_log)   <<<
		end

		it 'has an index page that can be reached' do
			visit audit_logs_path
			expect(page.status_code).to eq(200)
		end

		it 'renders audit log content' do   <<<
			visit audit_logs_path
			expect(page).to have_content(/PARK, DANIEL/)
		end

		it 'cannot be accessed by non admin users' do
			logout(:user)
			user = FactoryGirl.create(:user)
			login_as(user, :scope => :user)

			visit audit_logs_path
			expect(current_path).to eq(root_path)
		end
	end
end
```

- ![add](plus.png) [app/controllers/audit_logs_controller.rb]
```rb
class AuditLogsController < ApplicationController
	def index
		@audit_logs = AuditLog.all   <<<
		authorize @audit_logs
	end
end
```

![edit](edit.png) [app/views/audit_logs/index.html.erb]
```erb
<%= render @audit_logs %><br>
```

- $ touch app/views/audit_logs/_audit_log.html.erb
- ![add](plus.png) [app/views/audit_logs/_audit_log.html.erb]
```erb
<%= audit_log.user.full_name %>
```

- $ rspec [which will succeed!]

- ![edit](edit.png) [app/views/audit_logs/index.html.erb]
```erb
<h1>Audit Log Dashboard</h1>

<table class="table table-striped table-hover">
	<thead>
		<tr>
			<th>
				#
			</th>
			<th>
				Employee
			</th>
			<th>
				Week Starting
			</th>
			<th>
				confirmed At
			</th>
			<th>
				Status
			</th>
			<th></th>
			<th></th>
		</tr>
	</thead>
	<tbody>
		<%= render @audit_logs %>
	</tbody>
</table>
```

- ![edit](edit.png) [app/views/audit_logs/_audit_log.html.erb]
```erb
<tr>
	<td>
		<%= audit_log.id %>
	</td>
	<td>
		<%= audit_log.user.full_name %>
	</td>
	<td>
		<%= audit_log.start_date %>
	</td>
	<td>
		<%= audit_log.end_date %>
	</td>
	<td>
		<%= audit_log.status %>
	</td>
</tr>
```




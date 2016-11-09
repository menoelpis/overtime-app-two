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
	AuditLog.create!(user_id: User.last.id, status: 0, start_date: (Date.today - 6.days))
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



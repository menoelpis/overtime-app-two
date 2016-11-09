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
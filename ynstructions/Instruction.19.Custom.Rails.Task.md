# Overtime Application Workflow 19

## Creating a Custom Rails Task

- $ rails -T [which shows all tasks]
- $ rails g task notification sms

- ![edit](edit.png) [lib/tasks/notification.rake]
```rake
namespace :notification do
  desc "Sends SMS notification to employees asking them to log if they had overtime or not"   <<<
  task sms: :environment do
  	puts "I'm in a rake task"   <<<
  end
end
```

- $ rails -T [check if there is notification task]
- $ rails notification:sms [check the text output]

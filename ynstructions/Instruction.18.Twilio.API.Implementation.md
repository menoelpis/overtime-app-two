# Overtime Application Workflow 18

## Implementing the Twilio API for Sending Text Messages

### Gemfile Addition

* ![add](plus.png) gem 'twilio-ruby', '~> 4.11', '>= 4.11.1'
* ![add](plus.png) gem 'dotenv-rails', :groups => [:development, :test]

- $ bundle
- $ touch .env
- $ spring stop

* ![add](plus.png) [.env]

TWILIO_ACCOUNT_SID=YOURACCOUNTSID
TWILIO_AUTH_TOKEN=YOURAUTHTOKEN
TWILIO_PHONE_NUMBER=YOURPHONENUMBER

- $ rails c [>> ENV['TWILIO_PHONE_NUMBER'] will result in the phone number above]

![edit](edit.png) [config/application.rb]
```rb
.
.
.
module OvertimeAppKali
  class Application < Rails::Application
  	config.autoload_paths << Rails.root.join("lib")  <<<
  end
end
```

- $ touch lib/sms_tool.rb

![add](plus.png) [lib/sms_tool.rb]
```rb
module SmsTool
	def self.send_sms(number:, message:)
		puts "Sending SMS..."
		puts "#{message} to #{number}"
	end
end
```

- $ rails c [>> SmsTool.send_sms(number: 12345678, message: "my message")]

- $ touch lib/fake_sms.rb

![add](plus.png) [lib/fake_sms.rb]
```rb
module FakeSms
	Message = Struct.new(:number, :message)
	@messages = []

	def self.send_sms(number:, message:)
		@messages << Message.new(number, message)
	end
	
	def self.messages
		@messages
	end
end
```

![add](plus.png) [spec/spec_helper.rb]
```rb
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:each) do   <<<
  	stub_const("SmsTool", FakeSMS)
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
```

- $ rails c -e test
- >> SmsTool.send_sms(number:103214325, message: "some message")
- >> FakeSms.send_sms(number: 103432543, message: "yet another message")
- >> FakeSms.send_sms(number: 789432342, message: "one more message") 
- >> FakeSms.messages
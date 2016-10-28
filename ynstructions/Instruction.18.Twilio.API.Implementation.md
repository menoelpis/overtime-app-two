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
TWILIO_PHONE_NUMBER=+821076580774

- $ rails c [>> ENV['TWILIO_PHONE_NUMBER'] will result in the phone number above]

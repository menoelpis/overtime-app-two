# Overtime Application Workflow 03

## Devise Setup and Test

- $ rails generate devise:install
- ![edit](edit.png) [config/environments/development.rb]
```ruby
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
```
- $ rails generate devise:views
- ![edit](edit.png) [config/initializers/devise.rb]
```ruby
config.mailer_sender = 'no-reply@abideinhope.net'
```
- $ rails g devise User first_name:string last_name:string type:string
- $ rails db:migrate
- $ rails server [localhost:3000/users/sign_up -> Signup Process]
- $ rails console [type User.last]

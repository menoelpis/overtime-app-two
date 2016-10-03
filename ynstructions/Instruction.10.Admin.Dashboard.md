# Overtime Application Workflow 10

## Admin Dashboard via Administrate

- ![add](plus.png) [Gemfile] *add administrate gem for rails5 and its dependencies*
```rb
gem 'administrate', github: 'greetpoint/administrate', branch: 'rails5'
gem 'bourbon', '~> 4.2'
```

- $ rails generate administrate:install 

- ![add](plus.png) [app/assets/stylesheets/application.css.scss]
```scss
.
.
.
@import "bourbon";   <<<
.
.
.
```

- $ rails server [goto: localhost:3000/admin]
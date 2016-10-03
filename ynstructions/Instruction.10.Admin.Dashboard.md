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

- $ touch app/models/admin_user.rb
- ![add](plus.png) [app/models/admin_user.rb]
```rb
class AdminUser < User

end
```

- ![edit](edit.png) [config/routes]
```rb
Rails.application.routes.draw do
  namespace :admin do   <<<
    resources :users
		resources :posts
    resources :admin_users

    root to: "users#index"
  end

  resources :posts do   <<<
    member do
      get :approve
    end
  end
  devise_for :users, skip: [:registrations]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'static#homepage'
end
```

- $ rails generate administrate:install
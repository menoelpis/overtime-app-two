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

- $ touch app/models/admin_user.rb *add admin user model and etc*
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

- ![edit](edit.png) [app/dashboards/admin_user_dashboard.rb]
```rb
require "administrate/base_dashboard"

class AdminUserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    posts: Field::HasMany.with_options(searchable: false),
    id: Field::Number.with_options(searchable: false),
    email: Field::String.with_options(searchable: true),
    password: Field::String.with_options(searchable: false),
    sign_in_count: Field::Number.with_options(searchable: false),
    current_sign_in_at: Field::DateTime.with_options(searchable: false),
    last_sign_in_at: Field::DateTime.with_options(searchable: false),
    current_sign_in_ip: Field::String.with_options(searchable: false),
    last_sign_in_ip: Field::String.with_options(searchable: false),
    first_name: Field::String.with_options(searchable: false),
    last_name: Field::String.with_options(searchable: false),
    type: Field::String.with_options(searchable: false),
    created_at: Field::DateTime.with_options(searchable: false),
    updated_at: Field::DateTime.with_options(searchable: false),
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :posts,
    :email,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :posts,
    :email,
    :sign_in_count,
    :current_sign_in_at,
    :last_sign_in_at,
    :current_sign_in_ip,
    :last_sign_in_ip,
    :first_name,
    :last_name,
    :type,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :email,
    :password,
    :first_name,
    :last_name,
    :type,
  ].freeze

  # Overwrite this method to customize how admin users are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(admin_user)
  #   "AdminUser ##{admin_user.id}"
  # end
end
```

- ![edit](edit.png) [app/dashboards/user_dashboard.rb]
```rb
require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    posts: Field::HasMany.with_options(searchable: false),
    id: Field::Number.with_options(searchable: false),
    email: Field::String.with_options(searchable: true),
    password: Field::String.with_options(searchable: false),
    sign_in_count: Field::Number.with_options(searchable: false),
    current_sign_in_at: Field::DateTime.with_options(searchable: false),
    last_sign_in_at: Field::DateTime.with_options(searchable: false),
    current_sign_in_ip: Field::String.with_options(searchable: false),
    last_sign_in_ip: Field::String.with_options(searchable: false),
    first_name: Field::String.with_options(searchable: false),
    last_name: Field::String.with_options(searchable: false),
    type: Field::String.with_options(searchable: false),
    created_at: Field::DateTime.with_options(searchable: false),
    updated_at: Field::DateTime.with_options(searchable: false),
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :posts,
    :email,
    :type,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :posts,
    :email,
    :sign_in_count,
    :current_sign_in_at,
    :last_sign_in_at,
    :current_sign_in_ip,
    :last_sign_in_ip,
    :first_name,
    :last_name,
    :type,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :email,
    :password,
    :first_name,
    :last_name,
  ].freeze

  # Overwrite this method to customize how admin users are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(admin_user)
  #   "AdminUser ##{admin_user.id}"
  # end
end
```

- ![edit](edit.png) [app/dashboards/post_dashboard.rb]
```rb
require "administrate/base_dashboard"

class PostDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo.with_options(searchable: false),
    id: Field::Number.with_options(searchable: false),
    date: Field::DateTime.with_options(searchable: false),
    rationale: Field::Text.with_options(searchable: true),
    created_at: Field::DateTime.with_options(searchable: false),
    updated_at: Field::DateTime.with_options(searchable: false),
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :user,
    :id,
    :date,
    :rationale,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :user,
    :id,
    :date,
    :rationale,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :user,
    :date,
    :rationale,
  ].freeze

  # Overwrite this method to customize how posts are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(post)
  #   "Post ##{post.id}"
  # end
end
```

- $ touch spec/features/admin_dashboard_spec.rb

- ![add](plus.png) [spec/features/admin_dashboard_spec.rb]
```rb
require 'rails_helper'

describe 'admin dashboard' do
  it 'can be reached successfully' do
    visit admin_root_path
    expect(page.status_code).to eq(200)
  end

  it 'does not allow users to access without being signed in' do
    visit admin_root_path
    expect(current_path).to eq(new_user_session_path)
  end
end
```

- $ rspec [which will fail]

- ![edit](edit.png) [app/controllers/admin/application_controller.rb]
```rb
module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_user!   <<<
    before_action :authenticate_admin
    .
    .
    .
  end
end
```

- $ rspec [which will succeed]

- ![add](plus.png) [spec/features/admin_dashboard_spec.rb]
```rb
require 'rails_helper'

describe 'admin dashboard' do
  .
  .
  .
  it 'cannot be reached by a non admin users' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)

    visit admin_root_path
    expect(current_path).to eq(root_path)
  end

  it 'can be reached by an admin users' do
    admin_user = FactoryGirl.create(:admin_user)
    login_as(admin_user, :scope => :user)

    visit admin_root_path
    expect(current_path).to eq(admin_root_path)
  end
end
```

- $ rspec [which will fail]

- ![edit](edit.png) [app/controllers/admin/application_controller.rb]
```rb
module Admin
  def self.admin_types   <<<
    ['AdminUser']
  end

  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_admin

    def authenticate_admin   <<<
      unless Admin.admin_types.include?(current_user.try(:type))
        flash[:alert] = "You are not authorized to access this page"
        redirect_to(root_path)
      end
    end
  end
end
```

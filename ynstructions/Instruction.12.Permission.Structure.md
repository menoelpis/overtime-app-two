# Overtime Application Workflow 12

## Creating a Permission Structure

- ![add](plus.png) [Gemfile]
```rb
gem 'pundit', '~>1.1'
```

- $ rails generate pundit:install *install pundit*

- ![add](plus.png) [app/controller/application_controller.rb]
```rb
class ApplicationController < ActionController::Base
	include Pundit   <<<
  protect_from_forgery with: :exception
  before_action :authenticate_user!
end
```

- ![add](plus.png) [app/policies/application_policy.rb]
```rb
class ApplicationPolicy
  attr_reader :user, :record
  .
  .
  .
  def destroy?
    false
  end

  def admin_types   <<<
    ['AdminUser']
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end
  .
  .
  .

```

- $ touch app/policies/post_policy.rb
- ![add](plus.png) [app/policies/post_policy.rb]
```rb
class PostPolicy < ApplicationPolicy
	def update?
		record.user_id == user.id || admin_types.include?(user.type)
	end
end
```

- ![edit](edit.png) [app/controllers/posts_controller.rb]
```rb
class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy]
	.
	.
	.
	def edit
		authorize @post   <<<
	end

	def update
		authorize @post   <<<
		
		if @post.update(post_params)
			redirect_to @post, notice: 'Your post was edited successfully'
		else
			render :edit
		end
	end
	.
	.
	.
```

- ![add](plus.png) [spec/factories/users.rb] *add non authorized user*
```rb
factory :non_authorized_user, class: "User" do
	email { generate :email }
	first_name 'Non'
	last_name 'Authorized'
	password 'asdfasdf'
	password_confirmation 'asdfasdf'
end
```

- ![add](plus.png) [app/controllers/application_controller.rb]
```rb
class ApplicationController < ActionController::Base
	include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized   <<<

  private

  	def user_not_authorized
  		flash[:alert] = "You are not authorized to perform this action."
  		redirect_to(root_path)
  	end
end
```

- ![edit](edit.png) [spec/features/post_spec.rb] *quick fix for post edit error*
```rb
describe 'edit' do
	before do   <<<
		@edit_user = User.create(first_name: "Edit", last_name: "user", email: "edit@user.com", password: "asdfasdf", password_confirmation: "asdfasdf")
		login_as(@edit_user, :scope => :user)
		@edit_post = Post.create(date: Date.today, rationale: "asdf", user_id: @edit_user.id)
	end

	it 'can be edited' do
		visit edit_post_path(@edit_post)   <<<

		fill_in 'post[date]', with: Date.today
		fill_in 'post[rationale]', with: "Edited Content"
		click_on "Save"

		expect(page).to have_content("Edited Content")
	end

	it 'cannot be edited by a non authorized user' do
		logout(:user)
		non_authorized_user = FactoryGirl.create(:non_authorized_user)
		login_as(non_authorized_user, :scope => :user)

		visit edit_post_path(@edit_post)   <<<

		expect(current_path).to eq(root_path)
	end
end
```

- ![edit](edit.png) [app/views/layouts/application.html.erb]
```erb
<!DOCTYPE html>
<html>
  <head>
    <title>OvertimeAppKali</title>
    <%= csrf_meta_tags %>
    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>
  .
  .
  .
  <% if flash[:alert] %>   <<<
    <%= js add_gritter(flash[:alert], title: "Overtime App Alert", sticky: false) %>
  <% elsif flash[:error] %>
    <%= js add_gritter(flash[:error], title: "Overtime App Error", sticky: false) %>
  <% else %>
    <%= js add_gritter(flash[:notice], title: "Overtime App Notification", sticky: false) %>
  <% end %>

  </body>
</html>
```
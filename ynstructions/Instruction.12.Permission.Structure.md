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
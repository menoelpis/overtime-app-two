# Overtime Application Workflow 15

## How to Lock Records in Rails

- $ rspec --format documentation **prints all rspec test guideline**

- ![add](plus.png) [spec/features/approval_workflow_spec.rb]
```rb
require 'rails_helper'

describe 'navigate' do
	before do
		@admin_user = FactoryGirl.create(:admin_user)
		login_as(@admin_user, :scope => :user)
	end
	.
	.
	.
		it 'should not be editable by the post creator if status is approved' do   <<<
			logout(:user)
			user = FactoryGirl.create(:user)
			login_as(user, :scope => :user)

			@post.update(user_id: user.id, status: 'approved')

			visit edit_post_path(@post)

			expect(current_path).to eq(root_path)
		end
	end
end
```

- ![edit](edit.png) [app/policies/post_policy.rb]
```rb
class PostPolicy < ApplicationPolicy
	def update?
		return true if post_approved? && admin?
		return true if user_or_admin && !post_approved?
	end	

	private 

		def user_or_admin
			record.user_id == user.id || admin?
		end

		def admin?
			admin_types.include?(user.type)
		end

		def post_approved?
			record.approved?
		end
end
```

- Test to post as a user -> change status as an admin -> try to edit as a user
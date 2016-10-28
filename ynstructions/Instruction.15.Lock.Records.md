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

- ![edit](edit.png) [views/posts/index.html.erb]
```erb
		.
		.
		.
			<th>
				Rationale
			</th>
			<th>   <<<
				Status
			</th>
			<th></th>
			<th></th>
		</tr>
	</thead>
	<tbody>
		<%= render @posts %>
	</tbody>
</table>
```

- ![edit](edit.png) [views/posts/_post.html.erb]
```erb
<tr>
	.
	.
	.
	<td>
		<%= truncate(post.rationale) %>
	</td>
	<td>
		<%= post.status %>   <<<
	</td>
	.
	.
	.
</tr>
```

## Change the status color

- ![add](plus.png) [app/helpers/posts_helper.rb]
```rb
module PostsHelper
	def status_label status 
		status_span_generator status
	end

	private 

		def status_span_generator status
			case status
			when 'submitted'
				content_tag(:span, status.titleize, class: 'label label-primary')
			when 'approved'
				content_tag(:span, status.titleize, class: 'label label-success')
			when 'rejected'
				content_tag(:span, status.titleize, class: 'label label-danger')
			end
		end
end
```

- ![edit](edit.png) [views/posts/_post.html.erb]
```erb
<tr>
	.
	.
	.
	<td>
		<%= truncate(post.rationale) %>
	</td>
	<td>
		<%= status_label post.status %>   <<<
	</td>
	.
	.
	.
</tr>
```

## Hide the edit button when approved

- ![edit](edit.png) [views/posts/_post.html.erb]
```erb
	.
	.
	.
	<td>
		<%= link_to 'Edit', edit_post_path(post), id: "edit_#{post.id}" if policy(post).update? %>   <<<
	</td>
	.
	.
	.
</tr>


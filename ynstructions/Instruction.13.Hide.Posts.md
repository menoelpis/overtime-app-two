# Overtime Application Workflow 13

## Hide Posts from Non Authorized Users

- ![add](plus.png) [spec/factories/posts.rb]
```rb
factory :post_from_other_user, class: "Post" do
  date Date.yesterday
  rationale "Post 3 Rationale from Others"
  non_authorized_user
end
```

- ![edit](edit.png) [spec/features/post_spec.rb]
```rb
require 'rails_helper'

describe 'navigate' do
	before do
		@user = FactoryGirl.create(:user)   <<< user -> @user
		login_as(@user, :scope => :user)   <<< 
	end
	.
	.
	.
		it 'has a list of posts' do
			post1 = FactoryGirl.create(:post)
			post2 = FactoryGirl.create(:second_post)
			post2.update(user_id: @user.id)   <<< added
			visit posts_path
			expect(page).to have_content(/Post 1 Rationale | Post 2 Rationale/)
		end
		.
		.
		.
	describe 'delete' do
		it 'can be deleted' do
			@post = FactoryGirl.create(:post)
			# TODO refactor
			@post.update(user_id: @user.id)   <<<
			visit posts_path

			click_link("delete_post_#{@post.id}_from_index")
			expect(page.status_code).to eq(200)
		end
	end
```

- ![add](plus.png) [spec/features/post_spec.rb]
```rb
	it 'has a scope so that only post creators can see their posts' do
		post1 = FactoryGirl.create(:post)
		post2 = FactoryGirl.create(:second_post)
		other_user = User.create(first_name: 'Non', last_name: 'Authorized', email: "nonauth@example.com", password: "asdfasdf", password_confirmation: 
			"asdfasdf")
		post_from_other_user = Post.create(date: Date.today, rationale: "This post shouldn't be seen", user_id: other_user.id)
		
		visit posts_path
		
		expect(page).to_not have_content(/This post shouldn't be seen/)
	end
```
- ![edit](edit.png) [app/controllers/posts_controller.rb]
```rb
def index
	@posts = current_user.posts   <<<
end
```
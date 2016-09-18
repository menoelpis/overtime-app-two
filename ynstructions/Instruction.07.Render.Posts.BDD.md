 Overtime Application Workflow 07

## Rendering a List of Posts via BDD

- ![edit](edit.png) [spec/features/post_spec.rb]
```rb
require 'rails_helper'

describe 'navigate' do
	before do   <<<
		user = FactoryGirl.create(:user)
		login_as(user, :scope => :user)   
	end
	
	describe 'index' do
		before do   <<<
			visit posts_path  
		end
		
		it 'can be reached successfully' do
			expect(page.status_code).to eq(200)
		end

		it 'has a title of Post Index' do
			expect(page).to have_content(/Posts Index/)
		end

		it 'has a list of posts' do <<<
			post1 = FactoryGirl.create(:post)  
			post2 = FactoryGirl.create(:second_post)   
			visit posts_path   
			expect(page).to have_content(/Post 1 Rationale|Post 2 Rationale/)
		end
	end

	describe 'creation' do
		before do
			visit new_post_path
		end

		it 'has a new form that can be reached' do
			expect(page.status_code).to eq(200)
		end

		it 'can be created from new form page' do
			fill_in 'post[date]', with: Date.today
			fill_in 'post[rationale]', with: "Some Rationale"
			click_on "Save"

			expect(page).to have_content("Some Rationale")
		end

		it 'will have a user associated with it' do
			fill_in 'post[date]', with: Date.today
			fill_in 'post[rationale]', with: "User Association"
			click_on "Save"

			expect(User.last.posts.last.rationale).to eq("User Association")
		end
	end

end
```

- ![edit](edit.png) [app/controllers/posts_controller.rb]
```rb
.
.
.
def index
	@posts = Post.all   <<<
end
.
.
.
```

- ![edit](edit.png) [app/views/posts/index.html.erb]
```erb
<h1>Posts Index</h1>

<table class="table table-striped table-hover">
	<thead>
		<tr>
			<th>
				#
			</th>
			<th>
				Date
			</th>
			<th>
				User
			</th>
			<th>
				Rationale
			</th>
		</tr>
	</thead>
	<tbody>
		<% @posts.each do |post| %>
			<tr>
				<td>
					<%= post.id %>
				</td>
				<td>
					<%= post.date %>
				</td>
				<td>
					<%= post.user.last_name %>
				</td>
				<td>
					<%= truncate(post.rationale) %>
				</td>
			</tr>
		<% end %>
	</tbody>
</table>
```

- $ rspec [which will succeed but server test will fail]
- ![edit](edit.png) [db/seeds.rb]
```rb
@user = User.create(email: "test@test.com", password: "asdfasdf", password_confirmation: "asdfasdf", first_name: "Daniel", last_name: "Park") <<<

puts "1 user created" <<<

100.times do |post|
  Post.create!(date: Date.today, rationale: "#{post} rationale content", user_id: @user.id)
end

puts "100 posts have been created!"
```

## Refactoring the Index Action for Best Practice

- $ touch app/views/posts/_post.html.erb
- ![add](plus.png) [app/views/posts/_post.html.erb]
```erb
<tr>
	<td>
		<%= post.id %>
	</td>
	<td>
		<%= post.date %>
	</td>
	<td>
		<%= post.user.last_name %>
	</td>
	<td>
		<%= truncate(post.rationale) %>
	</td>
</tr>
```
- ![edit](edit.png) [app/views/posts/index.html.erb]
```erb
<h1>Posts Index</h1>

<table class="table table-striped table-hover">
.
.
.
	<tbody>
		<%= render @posts %> <<<
	</tbody>
</table>
```



# Overtime Application Workflow 05

## Building a Relational Connection Between Users and Posts

- ![edit](edit.png) [spec/features/post_spec.rb]
```rb
describe 'creation' do
	before do
		user = FactoryGirl.create(:user)
		login_as(user, :scope => :user)
		visit new_post_path
	end
.
.
.
	it 'will have a user associated with it' do
		fill_in 'post[date]', with: Date.today
		fill_in 'post[rationale]', with: "User Association"
		click_on "Save"

		expect(User.last.posts.last.rationale).to eq("User Association")
	end
end
```

- ![add](plus.png) [app/models/post.rb]
```rb
belongs_to :user
```

- ![add](plus.png) [app/models/user.rb]
```rb
has_many :posts
```
- $ rspec [errors: ...column posts.user_id does not exist...]

- $ rails db:setup [cleans database up]

- $ rails g migration add_users_to_posts user:references 
** [generates user_id, index, foreign_key]

- $ rspec [errors: ...undefined method `rationale' for nil...]

- ![add](plus.png) [app/controllers/post_controller.rb]
```rb
.
.
.
def create
@post = Post.new(post_params)
@post.user_id = current_user.id
.
.
.
```
** [access current_user.id which stored in a session cookie]

- ![edit](edit.png) [spec/factories/posts.rb]
```rb
FactoryGirl.define do
  factory :post do
    date Date.today
    rationale "Some Rationale"
    user <<<
  end

  factory :second_poast, class: "Post" do
  	date Date.yesterday
  	rationale "Some More Content"
  	user <<<
  end
end
```

- $ rspec [errors: ...Email has already been taken...]

- ![edit](edit.png) [spec/factories/posts.rb]
```rb
FactoryGirl.define do 
	sequence :email do |n|   
		"test#{n}@example.com" <<<
	end

	factory :user do
		email { generate :email } <<<
		first_name 'Daniel'
		last_name 'Park'
		password 'asdfasdf'
		password_confirmation 'asdfasdf'
	end

	factory :second_user do
		email { generate :email } <<<
		first_name 'John'
		last_name 'Kim'
		password 'asdfasdf'
		password_confirmation 'asdfasdf'
	end

end
```

- $ rspec [which will succeed!]

- ![add](plus.png) [app/controllers/application_controller.rb]
```rb
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user! <<<
end
```
** It will authenticate all users 

- $ rails console
- > User.create!(first_name: "Daniel"...)

- $ rails server
- [localhost:3000/users/sign_in] Sign In with Info Above
- Enter information -> Test

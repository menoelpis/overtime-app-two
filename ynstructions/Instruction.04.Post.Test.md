# Overtime Application Workflow 04

## Post Resource with Test

- $ rails generate resource Post date:date rationale:text
- $ rails db:migrate
- ![sub](minus.png) [spec/helpers/posts_helper_spec.rb]
- ![sub](minus.png) [spec/controllers/*]
- ![add](plus.png) [spec/factories/posts.rb]
```ruby
FactoryGirl.define do
  factory :post do
    date Date.today
    rationale "Some Rationale"
  end
end
```
- ![add](plus.png) [spec/model/post_spec.rb]
```ruby
require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "creation" do
  	before do
  		@user = FactoryGirl.create(:user)
  		login_as(@user, :scope => :user)
  		@post = FactoryGirl.create(:post)
  	end

  	it 'can be created' do
  		expect(@post).to be_valid
  	end
  	
  	it 'cannot be created without a date and rationale' do
  		@post.date = nil
  		@post.rationale = nil
  		expect(@post).to_not be_valid
  	end
  end

end
```
- ![add](plus.png) [app/models/post.rb] 
```ruby
validates_presence_of :date, :rationale
```

- ![add](plus.png) [app/controllers/posts_controllers.rb] 
```ruby
	def index
	end
```
- $ touch app/views/posts/index.html.erb [Add some content]

- $ touch spec/features/post_spec.rb
- ![add](plus.png) [spec/features/post_spec.rb]
```ruby
require 'rails_helper'

describe 'navigate' do
	
	describe 'homepage' do
		it 'can be reached successfully' do
			visit root_path
			expect(page.status_code).to eq(200)
		end

    it 'has a title of Post Index' do
      visit posts_path
      expect(page).to have_content(/Posts Index/)
    end
	end

end
```
- ![add](plus.png) [app/views/posts/index.html.erb]
```html
<h1>Posts Index</h1>
```
- $ rspec [which will succeed!]
- ![add](plus.png) [db/seeds.rb]
```ruby
100.times do |post|
  Post.create!(date: Date.today, rationale: "#{post} rationale content")
end

puts "100 posts have been created!"
```
- $ rails db:setup

- ![add](plus.png) [spec/features/post_spec.rb]
```ruby
describe 'creation' do
  it 'has a new form that can be reached' do
    visit new_post_path
    expect(page.status_code).to eq(200)
  end
end
```
- ![add](plus.png) [app/controllers/post_controller.rb]
```ruby
def new
end
```
- $ touch app/views/posts/new.html.erb
- $ rspec [which will succeed!]

- ![add](plus.png) [spec/features/post_spec.rb]
```ruby
describe 'creation' do
.
.
.
  it 'can be created from new form page' do
    visit new_post_path

    fill_in 'post[date]', with: Date.today
    fill_in 'post[rationale]', with: "Some Rationale"

    click_on "Save"

    expect(page).to have_content("Some Rationale")
  end
end
```
- $ rspec [which will fail]

- ![add](plus.png) [app/controllers/posts_controller.rb]
```ruby
def new
  @post = Post.new
end

def create
  @post = Post.find(params[:id])
  @post.save
end
```
- ![add](plus.png) [app/views/posts/new.html.erb]
```ruby
<%= form_for @post do |f| %>
  <%= f.date_field :date %>
  <%= f.text_area :rationale %>
  <%= f.submit 'Save' %>
<% end %>
```
- $ touch app/views/posts/show.html.erb
- ![add](plus.png) [app/views/posts/show.html.erb]
```ruby
<%= @post.inspect %>
```
- ![add](plus.png) [app/controllers/posts_controller.rb]
```ruby
def new
  @post = Post.new
end

def create
  @post = Post.new(params.require(:post).permit(:date, :rationale))
  @post.save
  redirect_to @post
end

def show
  @post = Post.find(params[:id])
end
```

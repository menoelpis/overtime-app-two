require 'rails_helper'

describe 'navigate' do
	before do
		user = FactoryGirl.create(:user)
		login_as(user, :scope => :user)
	end
	
	describe 'index' do
		before do
			visit posts_path
		end
		
		it 'can be reached successfully' do
			expect(page.status_code).to eq(200)
		end

		it 'has a title of Post Index' do
			expect(page).to have_content(/Posts Index/)
		end

		it 'has a list of posts' do
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
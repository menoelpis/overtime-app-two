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

	describe 'creation' do
		before do
			user = FactoryGirl.create(:user)
			login_as(user, :scope => :user)
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
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
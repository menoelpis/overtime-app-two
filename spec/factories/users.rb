FactoryGirl.define do 
	sequence :email do |n|
		"test#{n}@example.com"
	end

	factory :user do
		email { generate :email }
		first_name 'Daniel'
		last_name 'Park'
		password 'asdfasdf'
		password_confirmation 'asdfasdf'
		phone "3338887777"
	end

	factory :admin_user, class: "AdminUser" do
		email { generate :email }
		first_name 'Admin'
		last_name 'User'
		password 'asdfasdf'
		password_confirmation 'asdfasdf'
		phone "3338887777"
	end

	factory :non_authorized_user, class: "User" do
		email { generate :email }
		first_name 'Non'
		last_name 'Authorized'
		password 'asdfasdf'
		password_confirmation 'asdfasdf'
		phone "3338887777"
	end

end
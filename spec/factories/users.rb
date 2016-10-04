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
	end

	factory :second_user, class: "User" do
		email { generate :email }
		first_name 'John'
		last_name 'Kim'
		password 'asdfasdf'
		password_confirmation 'asdfasdf'
	end

	factory :admin_user, class: "AdminUser" do
		email { generate :email }
		first_name 'Admin'
		last_name 'User'
		password 'asdfasdf'
		password_confirmation 'asdfasdf'
	end

end
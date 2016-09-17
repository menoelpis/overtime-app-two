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

	factory :second_user do
		email { generate :email }
		first_name 'John'
		last_name 'Kim'
		password 'asdfasdf'
		password_confirmation 'asdfasdf'
	end

end
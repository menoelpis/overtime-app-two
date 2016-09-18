FactoryGirl.define do
  factory :post do
    date Date.today
    rationale "Post 1 Rationale"
    user
  end

  factory :second_post, class: "Post" do
  	date Date.yesterday
  	rationale "Post 2 Rationale"
  	user
  end
end

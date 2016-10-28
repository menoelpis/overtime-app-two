FactoryGirl.define do
  factory :post do
    date Date.today
    rationale "Post 1 Rationale"
    overtime_request 3.5
    user
  end

  factory :second_post, class: "Post" do
  	date Date.yesterday
  	rationale "Post 2 Rationale"
    overtime_request 0.5
  	user
  end

  factory :post_from_other_user, class: "Post" do
    date Date.yesterday
    rationale "Post 3 Rationale from Others"
    overtime_request 1.5
    non_authorized_user
  end
end

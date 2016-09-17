FactoryGirl.define do
  factory :post do
    date Date.today
    rationale "Some Rationale"
  end

  factory :second_poast, class: "Post" do
  	date Date.yesterday
  	rationale "Some More Content"
  end
end

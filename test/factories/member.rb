FactoryGirl.define do
  factory :member do
    budget
    sequence(:name) { |n| "Member #{n}" }
  end
end

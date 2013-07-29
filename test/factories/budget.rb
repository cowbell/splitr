FactoryGirl.define do
  factory :budget do
    sequence(:name) { |n| "Budget #{n}" }
  end
end

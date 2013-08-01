FactoryGirl.define do
  factory :transaction do
    budget
    amount 10.5
    description "Sex, Drugs and Rock 'n' Roll"
    participant_ids { [FactoryGirl.create(:member, budget: budget).id] }
  end
end

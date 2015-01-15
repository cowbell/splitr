FactoryGirl.define do
  factory :money_transaction do
    budget
    amount 10.5
    issued_on { Date.current }
    description "Sex, Drugs and Rock 'n' Roll"
    participant_ids { [FactoryGirl.create(:member, budget: budget).id] }
  end
end

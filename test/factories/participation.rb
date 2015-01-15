FactoryGirl.define do
  factory :participation do
    money_transaction
    member { FactoryGirl.create(:member, budget: money_transaction.budget) }
  end
end

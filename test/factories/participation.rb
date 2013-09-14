FactoryGirl.define do
  factory :participation do
    transaction
    member { FactoryGirl.create(:member, budget: transaction.budget) }
  end
end

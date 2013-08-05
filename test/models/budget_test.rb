require "test_helper"

class BudgetTest < ActiveSupport::TestCase
  setup do
    @budget = build(:budget)
  end

  test "saves successfully with valid attributes" do
    assert @budget.save!
  end

  test "is invalid without name" do
    budget = build(:budget, name: nil)
    assert budget.invalid?
    assert budget.errors[:name].present?
  end

  test "#total returns sum of transaction amounts" do
    budget = create(:budget)
    create_list(:transaction, 3, budget: budget, amount: 100)
    assert_equal 300, budget.total
  end

  test "#total_for_member returns sum of transaction amounts in which member participates" do
    budget = create(:budget)
    member = create(:member)
    other_member = create(:member)

    create(:transaction, budget: budget, amount: -20, participant_ids: [member.id, other_member.id])
    create(:transaction, budget: budget, amount: -5, participant_ids: [other_member.id])

    assert_equal -10, budget.total_for_member(member.id)
    assert_equal -15, budget.total_for_member(other_member.id)
  end
end

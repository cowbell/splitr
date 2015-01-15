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

  test "is invalid without precision" do
    budget = build(:budget, precision: nil)
    assert budget.invalid?
    assert budget.errors[:precision].present?
  end

  test "is invalid with negative precision" do
    budget = build(:budget, precision: -1)
    assert budget.invalid?
    assert budget.errors[:precision].present?
  end

  test "#total returns sum of transaction amounts" do
    budget = create(:budget)
    create_list(:money_transaction, 3, budget: budget, amount: 100)
    assert_equal 300, budget.total
  end

  test "#total_for_member returns sum of transaction amounts in which member participates" do
    budget = create(:budget)
    member = create(:member, budget: budget)
    other_member = create(:member, budget: budget)

    create(:money_transaction, budget: budget, amount: -20, participants: [member, other_member])
    create(:money_transaction, budget: budget, amount: -5, participants: [other_member])

    assert_equal -10, budget.total_for_member(member)
    assert_equal -15, budget.total_for_member(other_member)
  end

  test "#total_for_member returns sum of money_transaction amounts in which member pays" do
    budget = create(:budget)
    member = create(:member, budget: budget)
    other_member = create(:member, budget: budget)

    create(:money_transaction, budget: budget, amount: -20, participants: [member, other_member], payer: member)
    create(:money_transaction, budget: budget, amount: -5, participants: [other_member], payer: member)

    assert_equal 15, budget.total_for_member(member)
    assert_equal -15, budget.total_for_member(other_member)
  end

  test "#total_for_member returns precise results" do
    budget = create(:budget)
    members = create_list(:member, 3, budget: budget)
    create_list(:money_transaction, 9, amount: 1, budget: budget, participants: members)

    assert_equal 3, budget.total_for_member(members.first)
    assert_equal 3, budget.total_for_member(members.second)
    assert_equal 3, budget.total_for_member(members.third)
  end
end

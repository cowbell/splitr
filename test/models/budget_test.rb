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

  test "total is a sum of transaction amounts" do
    budget = create(:budget)
    create_list(:transaction, 3, budget: budget, amount: 100)
    assert_equal 300, budget.total
  end
end

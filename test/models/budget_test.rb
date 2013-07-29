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
end

require "test_helper"

class BudgetCreatorTest < ActiveSupport::TestCase
  test "saves budget" do
    user = create(:user)
    budget = build(:budget)
    BudgetCreator.create(budget, user)

    assert budget.persisted?
  end

  test "creates member with given budget and user" do
    user = create(:user)
    budget = build(:budget)
    BudgetCreator.create(budget, user)

    assert Member.where(budget_id: budget.id, user_id: user.id, name: user.name).exists?
  end

  test "does not create member when budget is invalid" do
    user = create(:user)
    budget = build(:budget, name: nil)

    refute BudgetCreator.create(budget, user)
    refute Member.exists?
  end

  test "does not save budget when member is invalid" do
    user = build(:user, name: nil)
    budget = build(:budget)

    assert_raises(ActiveRecord::RecordInvalid) do
      BudgetCreator.create(budget, user)
    end
    refute Member.exists?
    refute Budget.exists?
  end
end

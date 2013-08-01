require "test_helper"

class TransactionsControllerTest < ActionController::TestCase
  setup do
    @budget = create(:budget)
  end

  # new
  test "new raises exception when no user logged in" do
    assert_raises(CanCan::AccessDenied) { get :new, budget_id: @budget.id }
  end

  test "new raises exception logged in user does not belong to budget" do
    user = create(:user)
    session[:user_id] = user.id
    assert_raises(ActiveRecord::RecordNotFound) do
      get :new, budget_id: @budget.id
    end
  end

  test "new renders template when user logged in and belongs to budget" do
    user = create(:user)
    create(:member, budget: @budget, user: user)
    session[:user_id] = user.id
    get :new, budget_id: @budget.id

    assert_template :new
  end

  # create
  test "create raises exception when no user logged in" do
    transaction_params = attributes_for(:transaction, budget: @budget)
    assert_raises(CanCan::AccessDenied) do
      post :create, budget_id: @budget.id, transaction: transaction_params
    end
  end

  test "create raises exception logged in user does not belong to budget" do
    user = create(:user)
    session[:user_id] = user.id
    transaction_params = attributes_for(:transaction, budget: @budget)
    assert_raises(ActiveRecord::RecordNotFound) do
      post :create, budget_id: @budget.id, transaction: transaction_params
    end
  end

  test "create redirects to budget and adds transaction when user logged in and belongs to budget" do
    user = create(:user)
    create(:member, budget: @budget, user: user)
    session[:user_id] = user.id
    transaction_params = attributes_for(:transaction, budget: @budget, description: "4xBeer")
    post :create, budget_id: @budget.id, transaction: transaction_params

    assert_redirected_to budget_path(@budget)
    assert Transaction.where(description: "4xBeer", budget_id: @budget.id).exists?
  end

  test "create does not allow to assign participants outside budget" do
    user = create(:user)
    member = create(:member, budget: @budget, user: user)
    session[:user_id] = user.id
    member_outside_budget = create(:member, user: user)
    transaction_params = attributes_for(:transaction,
      budget: @budget,
      description: "4xBeer",
      participant_ids: [member.id, member_outside_budget.id]
    )
    post :create, budget_id: @budget.id, transaction: transaction_params

    assert_redirected_to budget_path(@budget)
    transaction = Transaction.find_by(description: "4xBeer", budget_id: @budget.id)
    assert_equal [member], transaction.participants
  end
end

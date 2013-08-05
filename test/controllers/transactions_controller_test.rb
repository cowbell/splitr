require "test_helper"

class TransactionsControllerTest < ActionController::TestCase
  setup do
    @budget = create(:budget)
  end

  # new
  test "new raises exception when no logged in user" do
    assert_raises(CanCan::AccessDenied) { get :new, budget_id: @budget.id }
  end

  test "new raises exception when logged in user does not belong to budget" do
    user = create(:user)
    session[:user_id] = user.id
    assert_raises(ActiveRecord::RecordNotFound) do
      get :new, budget_id: @budget.id
    end
  end

  test "new renders template when logged in user belongs to budget" do
    user = create(:user)
    create(:member, budget: @budget, user: user)
    session[:user_id] = user.id
    get :new, budget_id: @budget.id

    assert_template :new
  end

  # create
  test "create raises exception when no logged in user" do
    transaction_params = attributes_for(:transaction, budget: @budget)
    assert_raises(CanCan::AccessDenied) do
      post :create, budget_id: @budget.id, transaction: transaction_params
    end
  end

  test "create raises exception when logged in user does not belong to budget" do
    user = create(:user)
    session[:user_id] = user.id
    transaction_params = attributes_for(:transaction, budget: @budget)
    assert_raises(ActiveRecord::RecordNotFound) do
      post :create, budget_id: @budget.id, transaction: transaction_params
    end
  end

  test "create redirects to budget and adds transaction when logged in user belongs to budget" do
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

  # edit
  test "edit raises exception when no logged in user" do
    transaction = create(:transaction, budget: @budget)
    assert_raises(CanCan::AccessDenied) { get :edit, budget_id: @budget.id, id: transaction.id }
  end

  test "edit raises exception when logged in user does not belong to budget" do
    user = create(:user)
    transaction = create(:transaction, budget: @budget)
    session[:user_id] = user.id
    assert_raises(ActiveRecord::RecordNotFound) do
      get :edit, budget_id: @budget.id, id: transaction.id
    end
  end

  test "edit raises exception when transaction does not belong to budget" do
    user = create(:user)
    create(:member, budget: @budget, user: user)
    transaction = create(:transaction)
    session[:user_id] = user.id
    assert_raises(ActiveRecord::RecordNotFound) do
      get :edit, budget_id: @budget.id, id: transaction.id
    end
  end

  test "edit renders template when logged in user belongs to budget" do
    user = create(:user)
    create(:member, budget: @budget, user: user)
    transaction = create(:transaction, budget: @budget)
    session[:user_id] = user.id
    get :edit, budget_id: @budget.id, id: transaction.id

    assert_template :edit
  end

  # update
  test "update raises exception when no logged in user" do
    transaction = create(:transaction, budget: @budget)
    transaction_params = attributes_for(:transaction, budget: @budget)
    assert_raises(CanCan::AccessDenied) do
      put :update, budget_id: @budget.id, transaction: transaction_params, id: transaction.id
    end
  end

  test "update raises exception when logged in user does not belong to budget" do
    user = create(:user)
    session[:user_id] = user.id
    transaction = create(:transaction, budget: @budget)
    transaction_params = attributes_for(:transaction, budget: @budget)
    assert_raises(ActiveRecord::RecordNotFound) do
      put :update, budget_id: @budget.id, transaction: transaction_params, id: transaction.id
    end
  end

  test "update raises exception when transaction does not belong to budget" do
    user = create(:user)
    create(:member, budget: @budget, user: user)
    session[:user_id] = user.id
    transaction = create(:transaction)
    transaction_params = attributes_for(:transaction, budget: @budget)
    assert_raises(ActiveRecord::RecordNotFound) do
      put :update, budget_id: @budget.id, transaction: transaction_params, id: transaction.id
    end
  end

  test "update redirects to budget and updates transaction when logged in user belongs to budget" do
    user = create(:user)
    create(:member, budget: @budget, user: user)
    session[:user_id] = user.id
    transaction = create(:transaction, budget: @budget)
    transaction_params = attributes_for(:transaction, budget: @budget, description: "4xBeer")
    put :update, budget_id: @budget.id, transaction: transaction_params, id: transaction.id

    assert_redirected_to budget_path(@budget)
    assert Transaction.where(description: "4xBeer", budget_id: @budget.id).exists?
  end

  test "update does not allow to assign participants from outside budget" do
    user = create(:user)
    member = create(:member, budget: @budget, user: user)
    session[:user_id] = user.id
    member_outside_budget = create(:member, user: user)
    transaction = create(:transaction, budget: @budget)
    transaction_params = attributes_for(:transaction,
      budget: @budget,
      description: "4xBeer",
      participant_ids: [member.id, member_outside_budget.id]
    )
    put :update, budget_id: @budget.id, transaction: transaction_params, id: transaction.id

    assert_redirected_to budget_path(@budget)
    transaction = Transaction.find_by(description: "4xBeer", budget_id: @budget.id)
    assert_equal [member], transaction.participants
  end

  # destroy
  test "destroy raises exception when no logged in user" do
    transaction = create(:transaction, budget: @budget)
    assert_raises(CanCan::AccessDenied) { delete :destroy, budget_id: @budget.id, id: transaction.id }
  end

  test "destroy raises exception when logged in user does not belong to budget" do
    user = create(:user)
    transaction = create(:transaction, budget: @budget)
    session[:user_id] = user.id
    assert_raises(ActiveRecord::RecordNotFound) do
      delete :destroy, budget_id: @budget.id, id: transaction.id
    end
  end

  test "destroy raises exception when transaction does not belong to budget" do
    user = create(:user)
    create(:member, budget: @budget, user: user)
    transaction = create(:transaction)
    session[:user_id] = user.id
    assert_raises(ActiveRecord::RecordNotFound) do
      delete :destroy, budget_id: @budget.id, id: transaction.id
    end
  end

  test "destroy redirects to budget when logged in user belongs to budget" do
    user = create(:user)
    create(:member, budget: @budget, user: user)
    transaction = create(:transaction, budget: @budget)
    session[:user_id] = user.id
    delete :destroy, budget_id: @budget.id, id: transaction.id

    assert_redirected_to budget_path(@budget)
  end
end

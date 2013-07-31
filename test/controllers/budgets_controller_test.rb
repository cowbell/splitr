require "test_helper"

class BudgetsControllerTest < ActionController::TestCase
  # index
  test "index raises exception when no user logged in" do
    assert_raises(CanCan::AccessDenied) { get :index }
  end

  test "index renders template when user logged in" do
    session[:user_id] = create(:user).id
    get :index
    assert_template :index
  end

  test "index assigns logged in user budgets only" do
    user = create(:user)
    budget = create(:budget)
    create(:member, budget: budget, user: user)
    create(:budget) # User is not member of this budget
    session[:user_id] = user.id
    get :index

    assert_equal [budget], assigns(:budgets)
  end

  # show
  test "show raises exception when logged in user does not belong to budget" do
    user = create(:user)
    budget = create(:budget)
    session[:user_id] = user.id

    assert_raises(ActiveRecord::RecordNotFound) { get :show, id: budget.id }
  end

  test "show renders template when user logged in and belongs to budget" do
    user = create(:user)
    budget = create(:budget)
    create(:member, budget: budget, user: user)
    session[:user_id] = user.id
    get :show, id: budget.id

    assert_template :show
  end

  # new
  test "new raises exception when no user logged in" do
    assert_raises(CanCan::AccessDenied) { get :new }
  end

  test "new renders template when user logged in" do
    session[:user_id] = create(:user).id
    get :new
    assert_template :new
  end

  # create
  test "create raises exception when no user logged in" do
    assert_raises(CanCan::AccessDenied) { post :create, budget: attributes_for(:budget) }
  end

  test "create redirects to budgets, creates budget when user logged in" do
    session[:user_id] = create(:user).id
    budget_attributes = attributes_for(:budget)
    post :create, budget: budget_attributes
    assert_redirected_to budgets_path
    assert Budget.find_by(name: budget_attributes[:name]).present?
  end

  test "create creates budget member with logged in user" do
    user = create(:user, name: "John Doe")
    session[:user_id] = user.id
    post :create, budget: attributes_for(:budget)

    assert Member.where(user_id: user.id, name: "John Doe").exists?
  end
end

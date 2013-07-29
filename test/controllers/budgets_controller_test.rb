require "test_helper"

class BudgetsControllerTest < ActionController::TestCase
  test "new raises exception when no user logged in" do
    assert_raises(CanCan::AccessDenied) { get :new }
  end

  test "new renders template when user logged in" do
    session[:user_id] = create(:user).id
    get :new
    assert_template "new"
  end

  test "create raises exception when no user logged in" do
    assert_raises(CanCan::AccessDenied) { post :create, budget: attributes_for(:budget) }
  end

  test "create redirects to root, creates budget when user logged in" do
    session[:user_id] = create(:user).id
    budget_attributes = attributes_for(:budget)
    post :create, budget: budget_attributes
    assert_response :redirect
    assert Budget.find_by(name: budget_attributes[:name]).present?
  end
end

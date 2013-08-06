require "test_helper"

class MembersControllerTest < ActionController::TestCase
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
    assert_raises(CanCan::AccessDenied) { post :create, budget_id: @budget.id, member: {name: "John"} }
  end

  test "create raises exception when logged in user does not belong to budget" do
    user = create(:user)
    session[:user_id] = user.id
    assert_raises(ActiveRecord::RecordNotFound) do
      post :create, budget_id: @budget.id, member: {name: "John"}
    end
  end

  test "create redirects to budget members and adds member when logged in user belongs to budget" do
    user = create(:user)
    create(:member, budget: @budget, user: user)
    session[:user_id] = user.id
    post :create, budget_id: @budget.id, member: {name: "John"}

    assert_redirected_to budget_path(@budget)
    assert Member.where(name: "John", budget_id: @budget.id).exists?
  end

  # destroy
  test "destroy raises exception when no logged in user" do
    member = create(:member, budget: @budget)
    assert_raises(CanCan::AccessDenied) { delete :destroy, budget_id: @budget.id, id: member.id }
  end

  test "destroy raises exception when logged in user does not belong to budget" do
    user = create(:user)
    member = create(:member, budget: @budget)
    session[:user_id] = user.id
    assert_raises(ActiveRecord::RecordNotFound) do
      delete :destroy, budget_id: @budget.id, id: member.id
    end
  end

  test "destroy raises exception when member does not belong to budget" do
    user = create(:user)
    create(:member, budget: @budget, user: user)
    member = create(:member)
    session[:user_id] = user.id
    assert_raises(ActiveRecord::RecordNotFound) do
      delete :destroy, budget_id: @budget.id, id: member.id
    end
  end

  test "destroy redirects to budget members and adds member when logged in user belongs to budget" do
    user = create(:user)
    member = create(:member, budget: @budget, user: user)
    session[:user_id] = user.id
    delete :destroy, budget_id: @budget.id, id: member.id

    assert_redirected_to budget_path(@budget)
    refute Member.where(id: member.id).exists?
  end
end

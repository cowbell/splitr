require "test_helper"

class UsersControllerTest < ActionController::TestCase
  test "new renders template when no user logged in" do
    get :new
    assert_template "new"
  end

  test "new raises exception when user logged in" do
    session[:user_id] = create(:user).id
    assert_raises(CanCan::AccessDenied) { get :new }
  end

  test "create redirects to root, creates user, sets session when valid params given" do
    user_attributes = attributes_for(:user)
    post :create, user: user_attributes
    assert_response :redirect
    assert User.exists?(email: user_attributes[:email])
    assert session[:user_id].present?
  end

  test "create raises exception when user logged in" do
    session[:user_id] = create(:user).id
    assert_raises(CanCan::AccessDenied) { post :create, user: attributes_for(:user) }
  end
end

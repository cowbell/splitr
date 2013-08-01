require "test_helper"

class SessionsControllerTest < ActionController::TestCase
  test "new renders template when no logged in user" do
    get :new
    assert_template "new"
  end

  test "new raises exception when user logged in" do
    session[:user_id] = create(:user).id
    assert_raises(CanCan::AccessDenied) { get :new }
  end

  test "create redirects to root, sets session when valid params given" do
    user = create(:user)
    post :create, session: {email: user.email, password: user.password}
    assert_response :redirect
    assert session[:user_id].present?
  end

  test "create raises exception when no logged in user" do
    session[:user_id] = create(:user).id
    assert_raises(CanCan::AccessDenied) { post :create, session: {email: "user@example.com", password: "secret"} }
  end

  test "destroy redirects to root and unsets session" do
    session[:user_id] = create(:user).id
    delete :destroy
    assert_response :redirect
    assert session[:user_id].blank?
  end

  test "destroy raises exception when no logged in user" do
    assert_raises(CanCan::AccessDenied) { delete :destroy }
  end
end

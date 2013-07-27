require "test_helper"

class UsersControllerTest < ActionController::TestCase
  test "new renders template" do
    get :new
    assert_template "new"
  end

  test "create redirects to root, creates user, sets session when valid params given" do
    user_attributes = attributes_for(:user)
    post :create, user: user_attributes
    assert_response :redirect
    assert User.exists?(email: user_attributes[:email])
  end
end

require "test_helper"

class SessionTest < ActiveSupport::TestCase
  include ActiveModel::Lint::Tests

  setup do
    @user = create(:user)
    @model = @session = Session.new(email: @user.email, password: @user.password)
  end

  test "is valid with valid credentials" do
    assert @session.valid?
  end

  test "returns user when valid" do
    assert @session.valid?
    assert_equal @user, @session.user
  end

  test "returns user_id when valid" do
    assert @session.valid?
    assert_equal @user.id, @session.user_id
  end

  test "is invalid when user does not exist" do
    @session.email = "non-existing@example.com"
    assert @session.invalid?
    assert @session.errors[:password].present?
  end

  test "is invalid with incorrect password" do
    @session.password = "terces"
    assert @session.invalid?
    assert @session.errors[:password].present?
  end

  test "is invalid without email" do
    @session.email = nil
    assert @session.invalid?
    assert @session.errors[:email].present?
  end
end

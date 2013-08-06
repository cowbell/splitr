require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = build(:user)
  end

  test "saves successfully with valid attributes" do
    assert @user.save!
  end

  test "authenticate returns user when correct password given" do
    @user.save
    assert_equal @user, @user.authenticate("secret")
  end

  test "authenticate returns false when incorrect password given" do
    @user.save
    assert_equal false, @user.authenticate("wrong-secret")
  end

  test "is invalid with malformed email" do
    user = build(:user, email: "wrong-email")
    assert user.invalid?
    assert user.errors[:email].present?
  end

  test "is invalid with duplicate uppercased email" do
    create(:user, email: "john@doe.com")
    @user.email = "John@Doe.com"
    assert @user.invalid?
    assert @user.errors[:email].present?
  end

  test "is invalid without name" do
    user = build(:user, name: nil)
    assert user.invalid?
    assert user.errors[:name].present?
  end

  test "is invalid without password" do
    user = build(:user, password: nil)
    assert user.invalid?
    assert user.errors[:password].present?
  end

  test "is invalid with non-matching password confirmation" do
    @user.password_confirmation = "wrong-secret"
    assert @user.invalid?
    assert @user.errors[:password_confirmation].present?
  end
end

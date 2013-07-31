require "test_helper"

class MemberTest < ActiveSupport::TestCase
  setup do
    @member = build(:member)
  end

  test "saves successfully with valid attributes" do
    assert @member.save!
  end

  test "is invalid without name" do
    @member.name = nil
    assert @member.invalid?
    assert @member.errors[:name].one?
  end

  test "is invalid with same name within one budget" do
    create(:member, budget: @member.budget, name: @member.name)
    assert @member.invalid?
    assert @member.errors[:name].one?
  end

  test "is invalid with same user within one budget" do
    @member.user = create(:user)
    create(:member, budget: @member.budget, user: @member.user)
    assert @member.invalid?
    assert @member.errors[:user].one?
  end
end

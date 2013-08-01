require "test_helper"

class ParticipationTest < ActiveSupport::TestCase
  setup do
    @participation = build(:participation)
  end

  test "saves successfully with valid attributes" do
    assert @participation.save!
  end

  test "is invalid without member" do
    @participation.member = nil
    assert @participation.invalid?
    assert @participation.errors[:member].one?
  end

  test "is invalid without transaction" do
    @participation.transaction = nil
    assert @participation.invalid?
    assert @participation.errors[:transaction].one?
  end

  test "is invalid with same member within one transaction" do
    create(:participation, member: @participation.member, transaction: @participation.transaction)
    assert @participation.invalid?
    assert @participation.errors[:member].one?
  end
end

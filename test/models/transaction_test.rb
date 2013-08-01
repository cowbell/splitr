require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  setup do
    @transaction = build(:transaction)
  end

  test "saves successfully with valid attributes" do
    assert @transaction.save!
  end
end

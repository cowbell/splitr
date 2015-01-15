require "test_helper"

class MoneyTransactionTest < ActiveSupport::TestCase
  setup do
    @money_transaction = build(:money_transaction)
  end

  test "saves successfully with valid attributes" do
    assert @money_transaction.save!
  end

  test "saves successfully with negative amount" do
    @money_transaction.amount = "-1"
    assert @money_transaction.save!
  end

  test "is invalid without description" do
    @money_transaction.description = nil
    assert @money_transaction.invalid?
    assert @money_transaction.errors[:description].one?
  end

  test "is invalid without issued_on" do
    @money_transaction.issued_on = nil
    assert @money_transaction.invalid?
    assert @money_transaction.errors[:issued_on].one?
  end

  test "is invalid without amount" do
    @money_transaction.amount = nil
    assert @money_transaction.invalid?
    assert @money_transaction.errors[:amount].one?
  end

  test "is invalid with 0 amount" do
    @money_transaction.amount = 0
    assert @money_transaction.invalid?
    assert @money_transaction.errors[:amount].one?
  end

  test "is invalid with not numerical amount" do
    @money_transaction.amount = "1$"
    assert @money_transaction.invalid?
    assert @money_transaction.errors[:amount].one?
  end

  test "is invalid without budget" do
    @money_transaction.budget = nil
    assert @money_transaction.invalid?
    assert @money_transaction.errors[:budget].one?
  end

  test "is invalid without participants" do
    @money_transaction.participants = []
    assert @money_transaction.invalid?
    assert @money_transaction.errors[:participants].one?
  end

  test "is invalid when payer does not belong to budget" do
    @money_transaction.payer = create(:member)
    assert @money_transaction.invalid?
    assert @money_transaction.errors[:payer_id].one?
  end

  test "is valid when payer belongs to budget" do
    @money_transaction.save!
    @money_transaction.payer = create(:member, budget: @money_transaction.budget)
    assert @money_transaction.valid?
  end
end

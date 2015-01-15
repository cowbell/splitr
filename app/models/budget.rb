class Budget < ActiveRecord::Base
  has_many :members,      dependent: :destroy
  has_many :money_transactions, dependent: :destroy

  validates :name, presence: true
  validates :precision, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  def total
    money_transactions.sum(:amount)
  end

  def total_for_member(member)
    member_id = member.try(:id) || member
    member_transactions = money_transactions.joins(:participations).where(participations: {member_id: member_id})
    owed = member_transactions.to_a.sum { |transaction| Rational(transaction.amount.to_r, transaction.participants.count) }
    paid = -money_transactions.where(payer_id: member_id).sum(:amount).to_r
    paid + owed
  end
end

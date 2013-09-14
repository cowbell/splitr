class Budget < ActiveRecord::Base
  has_many :members,      dependent: :destroy
  has_many :transactions, dependent: :destroy

  validates :name, presence: true

  def total
    transactions.sum(:amount)
  end

  def total_for_member(member)
    member_id = member.try(:id) || member
    member_transactions = transactions.joins(:participations).where(participations: {member_id: member_id})
    owed = member_transactions.to_a.sum { |transaction| Rational(transaction.amount.to_r, transaction.participants.count) }
    paid = -transactions.where(payer_id: member_id).sum(:amount).to_r
    paid + owed
  end
end

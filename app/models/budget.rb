class Budget < ActiveRecord::Base
  has_many :members,      dependent: :destroy
  has_many :transactions, dependent: :destroy

  validates :name, presence: true

  def total
    transactions.sum(:amount)
  end

  def total_for_member(member_id)
    member_transactions = transactions.joins(:participations).where(participations: {member_id: member_id})
    member_transactions.reduce(0) do |sum, transaction|
      sum += Rational(transaction.amount, transaction.participants.count)
    end.to_f
  end
end

class Budget < ActiveRecord::Base
  has_many :members,      dependent: :destroy
  has_many :transactions, dependent: :destroy

  validates :name, presence: true
  validates :precision, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :locale, presence: true, inclusion: {in: I18n.available_locales.map(&:to_s)}

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

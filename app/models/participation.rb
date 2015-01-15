class Participation < ActiveRecord::Base
  belongs_to :money_transaction, inverse_of: :participations
  belongs_to :member, inverse_of: :participations

  validates :money_transaction, presence: true
  validates :member,      presence: true, uniqueness: {scope: :money_transaction_id, allow_nil: true}
  validate :member_belongs_to_budget

  def member_belongs_to_budget
    return unless money_transaction_id? and member_id?
    errors.add :member_id, :invalid unless money_transaction.budget.members.include?(member)
  end
end

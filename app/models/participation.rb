class Participation < ActiveRecord::Base
  belongs_to :transaction, inverse_of: :participations
  belongs_to :member, inverse_of: :participations

  validates :transaction, presence: true
  validates :member,      presence: true, uniqueness: {scope: :transaction_id, allow_nil: true}
  validate :member_belongs_to_budget

  def member_belongs_to_budget
    return unless transaction_id? and member_id?
    errors.add :member_id, :invalid unless transaction.budget.members.include?(member)
  end
end

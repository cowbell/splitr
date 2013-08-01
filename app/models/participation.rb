class Participation < ActiveRecord::Base
  belongs_to :transaction, inverse_of: :participations
  belongs_to :member

  validates :transaction, presence: true
  validates :member,      presence: true, uniqueness: {scope: :transaction_id, allow_nil: true}
end

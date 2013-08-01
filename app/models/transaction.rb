class Transaction < ActiveRecord::Base
  belongs_to :budget
  has_many :participations, inverse_of: :transaction
  has_many :participants, through: :participations, source: :member

  validates :budget,      presence: true
  validates :description, presence: true
  validates :amount,      presence: true, numericality: {allow_nil: true}
end

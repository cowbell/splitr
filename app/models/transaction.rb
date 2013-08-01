class Transaction < ActiveRecord::Base
  belongs_to :budget

  validates :budget,      presence: true
  validates :description, presence: true
  validates :amount,      presence: true
end

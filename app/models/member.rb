class Member < ActiveRecord::Base
  belongs_to :user
  belongs_to :budget
  has_many :participations, dependent: :destroy
  has_many :money_transactions, through: :participations, dependent: :nullify

  validates :name,   presence: true, uniqueness: {scope: :budget_id}
  validates :budget, presence: true
  validates :user,   uniqueness: {scope: :budget_id}, allow_nil: true
end

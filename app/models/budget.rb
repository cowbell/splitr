class Budget < ActiveRecord::Base
  has_many :members
  has_many :transactions

  validates :name, presence: true
end

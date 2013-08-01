class Budget < ActiveRecord::Base
  has_many :members,      dependent: :destroy
  has_many :transactions, dependent: :destroy

  validates :name, presence: true
end

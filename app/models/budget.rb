class Budget < ActiveRecord::Base
  validates :name, presence: true

  has_many :members
end

class Budget < ActiveRecord::Base
  validates :name, presence: true
end

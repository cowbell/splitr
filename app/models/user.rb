class User < ActiveRecord::Base
  has_secure_password

  has_many :memberships, class_name: "Member"
  has_many :budgets, through: :memberships

  validates :email, presence: true, format: {with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/}, uniqueness: {case_sensitive: false}
  validates :name,  presence: true
end

class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: {with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/}
  validates :name, presence: true
end

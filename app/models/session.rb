class Session
  include ActiveModel::Model

  attr_accessor :email, :password

  validates :email, presence: true
  validate :authenticity
  delegate :id, to: :user, prefix: true, allow_nil: true

  def user
    User.find_by(email: email).try(:authenticate, password)
  end

  private

  def authenticity
    errors.add(:password, :invalid) if email.present? and user.blank?
  end
end

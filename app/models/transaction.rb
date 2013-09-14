class Transaction < ActiveRecord::Base
  belongs_to :budget
  belongs_to :payer, class_name: "Member"
  has_many :participations, inverse_of: :transaction, dependent: :destroy
  has_many :participants, through: :participations, source: :member

  validates :budget,       presence: true
  validates :description,  presence: true
  validates :issued_on,    presence: true
  validates :amount,       presence: true, numericality: {allow_nil: true, other_than: 0}
  validates :participants, presence: true
  validate :payer_belongs_to_budget, if: :payer_id?

  def payer_belongs_to_budget
    errors.add :payer_id, :invalid unless budget.members.include?(payer)
  end

  def payer_name
    payer.try(:name).presence or "None"
  end
end

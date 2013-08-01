module BudgetsHelper
  def transaction_participants(transaction)
    transaction.participants.pluck(:name).to_sentence
  end
end

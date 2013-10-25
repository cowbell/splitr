module BudgetsHelper
  def transaction_participants(transaction)
    transaction.participants.pluck(:name).to_sentence
  end

  def budget_number_to_currency(budget, number)
    options = {
      precision: budget.precision,
      unit: budget.currency,
      separator: budget.separator,
      delimiter: budget.delimiter,
      format: budget.format,
      negative_format: budget.negative_format
    }

    number_to_currency(number, options.select { |key, value| value.present? or value != "" })
  end
end

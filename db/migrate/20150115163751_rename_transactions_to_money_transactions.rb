class RenameTransactionsToMoneyTransactions < ActiveRecord::Migration
  def change
    rename_table :transactions, :money_transactions
    rename_column :participations, :transaction_id, :money_transaction_id
  end
end

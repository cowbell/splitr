class ChangeDecimalPrecisionOnTransactionAmount < ActiveRecord::Migration
  def up
    change_column :transactions, :amount, :decimal, precision: 16, scale: 8, null: false
  end

  def down
    change_column :transactions, :amount, :decimal, precision: 8, scale: 2, null: false
  end
end

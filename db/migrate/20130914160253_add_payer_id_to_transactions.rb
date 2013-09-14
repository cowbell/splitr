class AddPayerIdToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :payer_id, :integer
  end
end

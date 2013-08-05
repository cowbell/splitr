class AddIssuedOnToTransaction < ActiveRecord::Migration
  def up
    add_column :transactions, :issued_on, :date

    Transaction.reset_column_information

    Transaction.find_each do |transaction|
      transaction.update_column(:issued_on, transaction.created_at)
    end

    change_column :transactions, :issued_on, :date, null: false
  end

  def down
    remove_column :transactions, :issued_on
  end
end

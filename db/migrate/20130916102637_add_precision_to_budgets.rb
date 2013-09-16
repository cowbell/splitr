class AddPrecisionToBudgets < ActiveRecord::Migration
  def change
    add_column :budgets, :precision, :integer
  end
end

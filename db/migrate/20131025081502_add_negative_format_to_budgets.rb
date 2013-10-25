class AddNegativeFormatToBudgets < ActiveRecord::Migration
  def change
    add_column :budgets, :negative_format, :string
  end
end

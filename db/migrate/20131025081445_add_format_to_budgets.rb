class AddFormatToBudgets < ActiveRecord::Migration
  def change
    add_column :budgets, :format, :string
  end
end

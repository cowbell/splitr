class AddSeparatorToBudgets < ActiveRecord::Migration
  def change
    add_column :budgets, :separator, :string
  end
end

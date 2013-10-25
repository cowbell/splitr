class AddDelimiterToBudgets < ActiveRecord::Migration
  def change
    add_column :budgets, :delimiter, :string
  end
end

class AddLocaleToBudgets < ActiveRecord::Migration
  def change
    add_column :budgets, :locale, :string
  end
end

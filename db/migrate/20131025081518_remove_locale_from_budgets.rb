class RemoveLocaleFromBudgets < ActiveRecord::Migration
  def change
    remove_column :budgets, :locale, :string
  end
end

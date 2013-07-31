class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.references :user, index: true
      t.references :budget, index: true, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :members, [:user_id, :budget_id], unique: true
    add_index :members, [:name, :budget_id], unique: true
  end
end

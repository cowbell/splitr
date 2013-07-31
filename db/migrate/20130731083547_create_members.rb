class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.references :user, index: true
      t.references :budget, index: true, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end

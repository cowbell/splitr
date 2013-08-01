class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.references :transaction, index: true
      t.references :member, index: true

      t.timestamps
    end

    add_index :participations, [:transaction_id, :member_id], unique: true
  end
end

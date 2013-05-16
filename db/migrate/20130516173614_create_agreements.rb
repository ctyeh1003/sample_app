class CreateAgreements < ActiveRecord::Migration
  def change
    create_table :agreements do |t|
      t.integer :agreer_id
      t.integer :agreed_id

      t.timestamps
    end
    add_index :agreements, :agreer_id
    add_index :agreements, :agreed_id
    add_index :agreements, [:agreer_id, :agreed_id], unique: true
  end
end

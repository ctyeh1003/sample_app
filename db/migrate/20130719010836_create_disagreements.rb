class CreateDisagreements < ActiveRecord::Migration
  def change
    create_table :disagreements do |t|
      t.integer :disagreer_id
      t.integer :disagreed_id

      t.timestamps
    end
    add_index :disagreements, :disagreer_id
    add_index :disagreements, :disagreed_id
    add_index :disagreements, [:disagreer_id, :disagreed_id], unique: true
  end
end

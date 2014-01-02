class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.integer :amount
      t.string :name
      t.text :comment

      t.timestamps
    end
  end
end

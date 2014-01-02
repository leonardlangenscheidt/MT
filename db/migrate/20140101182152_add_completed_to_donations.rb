class AddCompletedToDonations < ActiveRecord::Migration
  def change
  	add_column :donations, :completed, :boolean
  end
end

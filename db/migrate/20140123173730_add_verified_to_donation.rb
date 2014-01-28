class AddVerifiedToDonation < ActiveRecord::Migration
  def change
	 add_column :donations, :verified, :boolean
  end
end

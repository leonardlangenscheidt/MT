class Donation < ActiveRecord::Base
	validates :name, :amount, presence: true
end

class PagesController < ApplicationController
	def home
		@donations = Donation.all
		@goal = 100000
		@amounts = []
		@donations.each do |d|
			if d.completed == true
				@amounts.push(d.amount)
			end
		end
		@perc = (@amounts.sum.to_f/@goal)*100
	end
	def about
	end
	def bank
		@donation = Donation.find(params[:id])
	end
	def thank
		@donations = Donation.all
		@goal = 100000
		@amounts = []
		@donations.each do |d|
			if d.completed == true
				@amounts.push(d.amount)
			end
		end
		@perc = (@amounts.sum.to_f/@goal)*100
	end
	def help
	end
end

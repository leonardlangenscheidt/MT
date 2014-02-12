class PagesController < ApplicationController
	def home
		@donations = Donation.all
		@amounts = []
		@donations.each do |d|
			if d.completed == true
				@amounts.push(d.amount)
			end
		end
		@amount = @amounts.sum.to_f
		@goal = 700000
		@perc = (@amount/@goal)*100
	end
	def about
	end
	def bank
		@donation = Donation.find(params[:id])
	end
	def thank
		@donations = Donation.all
		@donation = Donation.find(params[:id])
		@amounts = []
		@donations.each do |d|
			if d.completed == true
				@amounts.push(d.amount)
			end
		end
		@amount = @amounts.sum.to_f
		@goal = 700000
		@perc = (@amount/@goal)*100
		@change = (@donation.amount.to_f/@goal)*100
	end
	def help
	end
end

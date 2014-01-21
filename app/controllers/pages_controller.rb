class PagesController < ApplicationController
	def home
	end
	def about
	end
	def thank
		@donation = Donation.find(params[:id])
	end
end

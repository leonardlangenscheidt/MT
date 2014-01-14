class DonationsController < ApplicationController
	before_action :set_donation, only: [:show, :edit, :update, :destroy]

	# GET /donations
	# GET /donations.json
	def index
		@donations = Donation.all
		@amounts = []
		@donations.each do |d|
			if d.completed == true
				@amounts.push(d.amount)
			end
		end
	end

	# GET /donations/1
	# GET /donations/1.json
	def show
	end

	# GET /donations/new
	def new
		@donation = Donation.new
	end

	# GET /donations/1/edit
	def edit
	end


	# POST /donations
	# POST /donations.json
	def create
		@donation = Donation.new(
			:amount => donation_params[:amount].to_f*100.to_i,
			:name => donation_params[:name],
			:comment => donation_params[:comment],
			:completed => false
			)

		respond_to do |format|
			if @donation.save
				format.html { redirect_to @donation, notice: "Donation was successfully created." }
				format.json { render action: 'show', status: :created, location: @donation }
			else
				format.html { render action: 'new' }
				format.json { render json: @donation.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /donations/1
	# PATCH/PUT /donations/1.json
	def update
		@donation.amount = donation_params[:amount].to_f*100.to_i
		@donation.name = donation_params[:name]
		@donation.comment = donation_params[:comment]
		respond_to do |format|
			if @donation.save
				format.html { redirect_to @donation, notice: 'Donation was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @donation.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /donations/1
	# DELETE /donations/1.json
	def destroy
		@donation.destroy
		respond_to do |format|
			format.html { redirect_to donations_url }
			format.json { head :no_content }
		end
	end

	def complete

		# Stripe.api_key = "sk_test_h41Izsyq3p3hpxOXtGkf6XVb"

		@donation = Donation.find(params[:id])

		# stripe documentation
		begin
			charge = Stripe::Charge.create(
				:amount => ((@donation.amount+30)/0.971).round,
				:currency => "eur",
				:card => params[:stripeToken],
				:description => "Thank you for your donation."
			)
		rescue Stripe::CardError => stripeerror
		end

		if charge
			@donation.completed = true
			@donation.save
			flash[:notice] = "Successfully completed donation! Thank you!"
			redirect_to "/donations/#{@donation.id}"
		else
			flash[:notice] = "Sorry. Something went wrong. Error: #{stripeerror}"
			redirect_to "/donations/#{@donation.id}"
		end
	end

	def manual_complete
		if current_admin.id<3
			@donation = Donation.find(params[:id])
			@donation.completed = true
			@donation.save
			redirect_to donations_path
		else
			flash[:notice] = "Please don't mess around with our backend."
			redirect_to donations_path
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_donation
			@donation = Donation.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def donation_params
			params.require(:donation).permit(:amount, :name, :comment, :completed)
		end
end

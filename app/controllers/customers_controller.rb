class CustomersController < ApplicationController
	def index
		if params[:filter].present?
			@customers = Customer.filter_by(params[:filter])
		else
			@customers = Customer.all
		end

		render json: @customers
	end
end

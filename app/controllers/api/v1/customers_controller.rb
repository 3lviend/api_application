class Api::V1::CustomersController < Api::BaseApiController
  before_action :get_customer, only: [:show, :update, :destroy]

  def index
    if params[:filter].present?
      @customers = Customer.filter_by(params[:filter])
    else
      @customers = Customer.eager_load(:address)
    end

    render json: @customers, each_serializer: CustomerSerializer, status: 200
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      render json: @customer, serialize: CustomerSerializer, status: 200
    else
      render json: {error: @customer.errors.full_messages}, status: 422
    end
  end

  # def show
  #   render json: @customer, serialize: CustomerSerializer, status: 200
  # end

  # def update
  #   if @customer.update(customer_params)
  #     render json: @customer, serialize: CustomerSerializer, status: 200
  #   else
  #     render json: {error: @customer.errors.full_messages}, status: 422
  #   end
  # end

  def destroy
    @customer.destroy
    render json: @customer, serialize: CustomerSerializer, status: 204
  end

  private

  def customer_params
    params.require(:customer).permit(:id, :name, :address_id, address_attributes: [:id, :street, :city, :zip_code])
  end

  def get_customer
    @customer = Customer.find(params[:id])
  end
end
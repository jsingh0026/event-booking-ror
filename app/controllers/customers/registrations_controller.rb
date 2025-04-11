# app/controllers/customers/registrations_controller.rb
class Customers::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    customer = Customer.new(sign_up_params)
    if customer.save
      render json: { message: "Signed up successfully", user: customer }, status: :created
    else
      render json: {  success: false, "message": "Something went wrong. Please check the input and try again.", errors: customer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.require(:customer).permit(:name, :email, :phone, :password, :password_confirmation)
  end
end

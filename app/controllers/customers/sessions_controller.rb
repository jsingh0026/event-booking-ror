# app/controllers/customers/sessions_controller.rb
class Customers::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    customer = Customer.find_by(email: params[:customer][:email])

    unless customer&.valid_password?(params[:customer][:password])
      return render_login_error
    end

    # Let Devise handle JWT issuing
    super
  end

  private

  def respond_with(resource, _opts = {})
    render json: { success: true, message: "Logged in successfully", user: resource }, status: :ok
  end
end

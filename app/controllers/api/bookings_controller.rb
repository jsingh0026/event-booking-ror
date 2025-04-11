# app/controllers/api/bookings_controller.rb
class Api::BookingsController < Api::BaseController
  before_action :authenticate_customer!

  def create
    booking = current_customer.bookings.new(booking_params)
    if booking.save
      render json: booking, status: :created
    else
      render json: { errors: booking.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:event_id, :ticket_id, :quantity)
  end
end

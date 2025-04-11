class Customers::BookingsController < ApplicationController
  before_action :authenticate_customer!

  def create
    ticket = Ticket.find_by(id: booking_params[:ticket_id], event_id: booking_params[:event_id])
    return render json: { success: false, message: "Invalid ticket or event" }, status: :unprocessable_entity unless ticket

    quantity = booking_params[:quantity].to_i

    if ticket.availability < quantity
      return render json: { success: false, message: "Not enough tickets available" }, status: :unprocessable_entity
    end

    total_price = ticket.price * quantity

    Booking.transaction do
      booking = current_customer.bookings.new(
        ticket: ticket,
        event_id: booking_params[:event_id],
        quantity: quantity,
        total_price: total_price
      )

      if booking.save
        ticket.update!(availability: ticket.availability - quantity)

      BookingConfirmationJob.perform_later(booking.id)

        render json: {
            success: true,
            booking: ActiveModelSerializers::SerializableResource.new(booking, serializer: BookingSerializer)
          }, status: :created
      else
        render json: { success: false, errors: booking.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  private
  def booking_params
    params.require(:booking).permit(:event_id, :ticket_id, :quantity)
  end
end

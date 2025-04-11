class BookingConfirmationJob < ApplicationJob
  queue_as :default

  def perform(booking_id)
    booking = Booking.includes(:ticket, :event, :customer).find_by(id: booking_id)

    if booking
      puts "Sending email confirmation to #{booking.customer.email} for booking ID #{booking.id}"
      puts "Event: #{booking.event.title}, Ticket: #{booking.ticket.ticket_type}, Quantity: #{booking.quantity}"
    else
      puts "Booking ID #{booking_id} not found. Email not sent."
    end
  end
end

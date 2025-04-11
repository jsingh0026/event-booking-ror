# app/jobs/send_booking_update_notification_job.rb
class SendBookingUpdateNotificationJob < ApplicationJob
  queue_as :default

  def perform(event_id)
    # Find all bookings related to the event
    bookings = Booking.where(event_id: event_id)

    # Iterate over each booking and print a notification (simulating sending an email)
    bookings.each do |booking|
      customer = booking.customer
      # Print a statement simulating the email sending
      puts "Sending email to customer #{customer.email} about the event update for Event ##{event_id}"
    end
  end
end

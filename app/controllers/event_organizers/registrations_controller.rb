# app/controllers/event_organizers/registrations_controller.rb
class EventOrganizers::RegistrationsController < ApplicationController
  def create
    event_organizer = EventOrganizer.new(sign_up_params)

    if event_organizer.save
      render json: {  success: true, message: "Signup successful", event_organizer: event_organizer }, status: :created
    else
      render json: {  success: false, "message": "Something went wrong. Please check the input and try again.", errors: event_organizer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.require(:event_organizer).permit(:name, :email, :phone, :password, :password_confirmation)
  end
end

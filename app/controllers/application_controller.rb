class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  prepend DeviseErrorResponder

    # For Devise to respond with JSON instead of redirect
    respond_to :json

    # Handle redirect attempts in API mode
    def authenticate_user!(opts = {})
      head :unauthorized unless current_event_organizer || current_customer
    end

    # Handle failed Devise auths
    rescue_from ActionController::InvalidAuthenticityToken do
      render json: { error: "Invalid authenticity token" }, status: :unauthorized
    end
end

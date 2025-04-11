class EventOrganizers::SessionsController < Devise::SessionsController
  prepend DeviseErrorResponder

  respond_to :json

  def create
    organizer = EventOrganizer.find_by(email: params[:event_organizer][:email])

    if organizer&.valid_password?(params[:event_organizer][:password])
      token, _payload = Warden::JWTAuth::UserEncoder.new.call(
        organizer,
        :event_organizer,
        nil
      )
      render json: {
        success: true,
        message: "Logged in successfully",
        token: token,
        user: {
          id: organizer.id,
          name: organizer.name,
          email: organizer.email
        }
      }, status: :ok
    else
      render_login_error
    end
  end
end

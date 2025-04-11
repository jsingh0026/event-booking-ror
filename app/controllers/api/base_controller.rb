class Api::BaseController < ApplicationController
  before_action :authenticate_any!

  private

  def authenticate_any!
    unless current_event_organizer || current_customer
      render json: { error: "You need to sign in or sign up." }, status: :unauthorized
    end
  end

  def current_user
    current_event_organizer || current_customer
  end
end

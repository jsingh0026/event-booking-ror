class EventsController < ApplicationController
  prepend DeviseErrorResponder

  before_action :authenticate_user!
  before_action :set_event, only: [ :show ]

  def index
    if current_event_organizer
      # Event Organizer: only their own events
      events = current_event_organizer.events.includes(:tickets).where(deleted_at: nil)
    elsif current_customer
      # Customer: all active events
      events = Event.includes(:tickets).where(deleted_at: nil)
    else
      return render json: { success: false, error: "Unauthorized access" }, status: :unauthorized
    end

    render json: events
  end

  def show
    if current_event_organizer
      unless @event.event_organizer_id == current_event_organizer.id
        return render json: { success: false, error: "Unauthorized access" }, status: :unauthorized
      end
    elsif !current_customer
      return render json: { success: false, error: "Unauthorized access" }, status: :unauthorized
    end

    render json: @event
  end

  private

  def authenticate_user!
    unless current_event_organizer || current_customer
      render json: { success: false, error: "Unauthorized access" }, status: :unauthorized
    end
  end

  def set_event
    @event = Event.includes(:tickets).find_by(id: params[:id], deleted_at: nil)
    render json: { success: false, error: "Event not found" }, status: :not_found unless @event
  end
end

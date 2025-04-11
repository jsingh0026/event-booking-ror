# app/controllers/api/events_controller.rb
class Api::EventsController < Api::BaseController
  before_action :authenticate_event_organizer!

  def index
    render json: Event.all
  end

  def create
    event = current_event_organizer.events.build(event_params)
    if event.save
      render json: event, status: :created
    else
      render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    event = current_event_organizer.events.find(params[:id])
    if event.update(event_params)
      render json: event
    else
      render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :date, :venue)
  end
end

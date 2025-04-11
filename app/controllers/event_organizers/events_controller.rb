class EventOrganizers::EventsController < ApplicationController
  prepend DeviseErrorResponder

  before_action :authenticate_event_organizer!
  before_action :set_event, only: [ :update, :destroy ]

  def create
    event = current_event_organizer.events.new(event_params)

    if event.save
      render json: {
        success: true,
        event: ActiveModelSerializers::SerializableResource.new(event, serializer: EventSerializer)
      }, status: :created
    else
      render json: { success: false, errors: event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if params[:event] && params[:event][:tickets_attributes]
      params[:event][:tickets_attributes].each do |ticket_attrs|
        if ticket_attrs[:id].present? && !@event.tickets.exists?(id: ticket_attrs[:id])
          return render json: { success: false, error: "Invalid ticket ID #{ticket_attrs[:id]}" }, status: :unprocessable_entity
        end
      end
    end

    if @event.update(event_params)
      SendBookingUpdateNotificationJob.perform_later(@event.id)
      render json: { success: true, event: ActiveModelSerializers::SerializableResource.new(@event, serializer: EventSerializer) }
    else
      render json: { success: false, errors: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end
  def destroy
    ActiveRecord::Base.transaction do
      @event.tickets.each(&:soft_delete)
      if @event.soft_delete
        render json: { success: true, message: "Event and associated tickets soft-deleted successfully" }, status: :ok
      else
        render json: { success: false, errors: @event.errors.full_messages }, status: :unprocessable_entity
      end
    end
  rescue => e
    render json: { success: false, error: e.message }, status: :internal_server_error
  end

  private

  def set_event
    @event = current_event_organizer.events.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { success: false, error: "Event not found" }, status: :not_found
  end

  def event_params
    params.require(:event).permit(:title, :description, :venue, :date,
    tickets_attributes: [ :id, :ticket_type, :price, :availability, :_destroy ])
  end
end

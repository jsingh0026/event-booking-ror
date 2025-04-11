class BookingSerializer < ActiveModel::Serializer
  attributes :id, :event_id, :ticket_id, :quantity, :total_price

  belongs_to :ticket
  belongs_to :event
end

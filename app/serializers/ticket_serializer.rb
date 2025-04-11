class TicketSerializer < ActiveModel::Serializer
  attributes :id, :ticket_type, :price, :availability
end

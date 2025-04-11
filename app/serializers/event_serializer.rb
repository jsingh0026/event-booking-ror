class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :date, :venue, :event_organizer_id

  has_many :tickets
end

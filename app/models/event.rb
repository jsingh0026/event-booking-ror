class Event < ApplicationRecord
  belongs_to :event_organizer
  has_many :tickets, dependent: :destroy
  has_many :bookings

  accepts_nested_attributes_for :tickets, allow_destroy: true

  validates :title, :venue, :date, presence: true
  default_scope { where(deleted_at: nil) }

  def soft_delete
    update(deleted_at: Time.current)
  end
end

class Ticket < ApplicationRecord
  belongs_to :event

  default_scope { where(deleted_at: nil) }

  def soft_delete
    update(deleted_at: Time.current)
  end
end

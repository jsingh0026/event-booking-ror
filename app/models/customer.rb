class Customer < ApplicationRecord
  # Devise modules for authentication
  devise :database_authenticatable, :registerable,
       :validatable, :jwt_authenticatable,
       jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  # Validations
  validates :name, presence: true
  validates :email, presence: true
  validates :password, confirmation: true, length: { minimum: 6 }, if: -> { password.present? }
  validates :password_confirmation, presence: true, if: -> { password.present? }

  # Optional field
  validates :phone, length: { maximum: 15 }, allow_blank: true

  has_many :bookings
end

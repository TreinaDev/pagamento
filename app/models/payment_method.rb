class PaymentMethod < ApplicationRecord
  validates :name, :tax, :image, presence: true
  has_one_attached :image
  has_many :payment_settings, dependent: :destroy
  has_many :client_profiles, through: :payment_settings
end

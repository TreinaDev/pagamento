class PaymentMethod < ApplicationRecord
  validates :name, :tax, presence: true
  has_many :payment_settings, dependent: :destroy
  has_many :client_profiles, through: :payment_settings
  has_many :payment_companies, dependent: :destroy
  has_many :orders
end

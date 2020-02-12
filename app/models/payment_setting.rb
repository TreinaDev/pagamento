class PaymentSetting < ApplicationRecord
  belongs_to :client_profile
  belongs_to :payment_method
  validates :discount, :interest_rate, :installments, presence: true
end

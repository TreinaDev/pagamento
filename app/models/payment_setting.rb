class PaymentSetting < ApplicationRecord
  belongs_to :client_profile
  belongs_to :payment_method
end

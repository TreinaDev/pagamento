class Order < ApplicationRecord
  validates :client_token, :order_id, :order_value, :client_profile_id,
            :payment_method_id, presence: true
  belongs_to :client_profile
  belongs_to :payment_method
end

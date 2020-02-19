class Order < ApplicationRecord
  validates :client_token, :order_id, :order_value, :client_profile_id,
            :payment_method_id, :order_installments, :order_installments_value,
            presence: true
  belongs_to :client_profile
  belongs_to :payment_method

  def calculate_client_value
    self.client_value = order_value - (order_value * payment_method.tax)
  end
end

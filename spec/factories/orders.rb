FactoryBot.define do
  factory :order do
    client_profile
    payment_method
    client_token { client_profile.auth_token }
    order_id { 1 }
    order_value { 500 }
    order_installments { 1 }
    order_installments_value { 500 }
    client_value { order_value * order.payment_method.tax }
  end
end

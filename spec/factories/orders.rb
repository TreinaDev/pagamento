FactoryBot.define do
  factory :order do
    client_profile
    client_token { client_profile.auth_token }
    order_id { 1 }
    order_value { 500 }
  end
end

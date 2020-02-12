FactoryBot.define do
  factory :order do
    client_token { "MyString" }
    order_id { 1 }
    order_value { "9.99" }
    references { "" }
    references { "" }
  end
end

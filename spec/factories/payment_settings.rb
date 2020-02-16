FactoryBot.define do
  factory :payment_setting do
    client_profile
    payment_method
    discount { '9.99' }
    interest_rate { '9.99' }
    installments { 1 }
  end
end

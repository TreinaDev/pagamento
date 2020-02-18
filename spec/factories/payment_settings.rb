FactoryBot.define do
  factory :payment_setting do
    client_profile
    payment_method
    discount { '0.1' }
    interest_rate { '0.5' }
    installments { 1 }
  end
end

FactoryBot.define do
  factory :payment_setting do
    client_profile
    payment_method
    discount { '10' }
    interest_rate { '50' }
    installments { 1 }
  end
end

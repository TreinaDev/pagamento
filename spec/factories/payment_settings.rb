FactoryBot.define do
  factory :payment_setting do
    client_profile { nil }
    payment_method { nil }
    discount { '0.1' }
    interest_rate { '0.5' }
    installment { 1 }
  end
end

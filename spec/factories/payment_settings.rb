FactoryBot.define do
  factory :payment_setting do
    client_profile { nil }
    payment_method { nil }
    discount { '9.99' }
    interest_rate { '9.99' }
    installment { 1 }
  end
end

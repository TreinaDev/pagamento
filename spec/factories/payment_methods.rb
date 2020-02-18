FactoryBot.define do
  factory :payment_method do
    name { 'Cartão de Debito' }
    tax { 0.05 }

    trait :debit do
      name { 'Débito em Conta' }
    end

    trait :digital_transfer do
      name { 'Paypal' }
    end

    trait :boleto do
      name { 'Boleto' }
    end

    trait :credit do
      name { 'Cartão de Crédito' }
    end
  end
end

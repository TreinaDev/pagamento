Factory.define do
  factory :payment_method do
    image_path = Rails.root.join('spec/support/boleto.png')
    name { 'Cartão de Debito' }
    tax { 0.5 }
    image { fixture_file_upload(image_path, 'image/png') }

    trait :debit do
      name { 'Débito em Conta' }
      image_path = Rails.root.join('spec/support/visa.png')
      image { fixture_file_upload(image_path, 'image/png') }
    end

    trait :digital_transfer do
      name { 'Paypal' }
      image_path = Rails.root.join('spec/support/paypal.png')
      image { fixture_file_upload(image_path, 'image/png') }
    end

    trait :boleto do
      name { 'Boleto' }
      image_path = Rails.root.join('spec/support/boleto.png')
      image { fixture_file_upload(image_path, 'image/png') }
    end

    trait :credit do
      name { 'Cartão de Crédito' }
      image_path = Rails.root.join('spec/support/mastercard.png')
      image { fixture_file_upload(image_path, 'image/png') }
    end
  end
end

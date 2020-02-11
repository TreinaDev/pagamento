FactoryBot.define do


  factory :payment_method do
    image_path1 = Rails.root.join('spec/support/boleto.png')
    name { 'Cartão de Debito' }
    tax { 0.5 }
    image { fixture_file_upload(image_path1, 'image/png') }
    

    trait :debit do
      name { 'Débito em Conta' }
      image_path2 = Rails.root.join('spec/support/visa.png')
      image { fixture_file_upload(image_path2, 'image/png') }
    end

    trait :digital_transfer do
      name { 'Paypal' }
      image_path3 = Rails.root.join('spec/support/paypal.png')
      image { fixture_file_upload(image_path3, 'image/png') }
    end

    trait :boleto do
      name { 'Boleto' }
      image_path4 = Rails.root.join('spec/support/boleto.png')
      image { fixture_file_upload(image_path4, 'image/png') }
    end
    
    trait :credit do
      name { 'Cartão de Crédito' }
      image_path5 = Rails.root.join('spec/support/mastercard.png')
      image { fixture_file_upload(image_path5, 'image/png') }
    end
  end
end

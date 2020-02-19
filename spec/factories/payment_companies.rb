FactoryBot.define do
  factory :payment_company do
    name { 'MasterCard' }
    image_path_master = Rails.root.join('spec/support/mastercard.png')
    image { fixture_file_upload(image_path_master, 'image/png') }

    trait :visa do
      name { 'Visa' }
      image_path_visa = Rails.root.join('spec/support/visa.png')
      image { fixture_file_upload(image_path_visa, 'image/png') }
    end

    trait :boleto do
      name { 'Boleto' }
      image_path_boleto = Rails.root.join('spec/support/boleto.png')
      image { fixture_file_upload(image_path_boleto, 'image/png') }
    end

    trait :paypal do
      name { 'Paypal' }
      image_path_paypal = Rails.root.join('spec/support/paypal.png')
      image { fixture_file_upload(image_path_paypal, 'image/png') }
    end
  end
end

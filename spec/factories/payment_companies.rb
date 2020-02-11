FactoryBot.define do
  factory :payment_company do
    name { 'MasterCard' }
    image_path = Rails.root.join('spec/support/mastercard.png')
    image { fixture_file_upload(image_path, 'image/png') }
    payment_method
  end
end

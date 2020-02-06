require 'rails_helper'

feature 'client views payments methods' do
  scenario 'sucessfully' do
    image_path = Rails.root.join('spec/support/mastercard.png')
    client = create(:client)
    payment = build(:payment_method, name: 'Débito', tax: 0.5)
    payment.image.attach(io: File.open(image_path),
                         filename: 'mastercard.png')
    payment.save
    payment1 = build(:payment_method, name: 'Crédito', tax: 0.5)
    payment1.image.attach(io: File.open(image_path),
                          filename: 'mastercard.png')
    payment1.save

    login_as(client, scope: :client)
    visit client_dashboard_index_path
    click_on 'Meios de Pagamento'

    expect(page).to have_content(payment.name)
    expect(page).to have_content(payment1.name)
  end
  scenario 'and must be logged in' do
    visit client_dashboard_index_path

    expect(current_path).to eq new_client_session_path
  end
end

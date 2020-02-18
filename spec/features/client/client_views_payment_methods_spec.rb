require 'rails_helper'

feature 'client views payments methods' do
  scenario 'sucessfully' do
    client = create(:client)
    create(:client_profile, client: client)
    payment = build(:payment_method, name: 'Débito', tax: 0.5)

    payment.save
    payment1 = build(:payment_method, name: 'Crédito', tax: 0.5)
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

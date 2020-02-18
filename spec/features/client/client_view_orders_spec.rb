require 'rails_helper'

feature 'Client view orders' do
  scenario 'Sucessfully' do
    client = create(:client)
    create(:client_profile, client: client)
    create(:payment_method, :debit)
    create(:payment_method, :credit)

    login_as(client, scope: :client)
    visit client_dashboard_index_path

    expect(page).to have_content('Pedidos')
  end
end

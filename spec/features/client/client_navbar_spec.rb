require 'rails_helper'

describe 'Client view navbar options' do
  scenario 'successfully' do
    client = create(:client)
    create(:client_profile, client: client,
                            auth_token: 'ABC1234')

    login_as client, scope: :client
    visit root_path

    expect(page).to have_content('Meus meios de pagamento')
    expect(page).to have_content('Dashboard')
    expect(page).to have_content('Meu Perfil')
    expect(page).to have_content('Token: ABC1234')
    expect(page).to have_content('Logout')
  end
end

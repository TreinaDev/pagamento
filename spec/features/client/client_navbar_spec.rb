require 'rails_helper'

describe 'Client view navbar options' do
  scenario 'successfully' do
    client = create(:client)
    client_profile = create(:client_profile, client: client,
                                             auth_token: 'ABC1234')

    login_as client, scope: :client
    visit root_path

    expect(page).to have_content('Meus meios de pagamento')
    expect(page).to have_content('Dashboard')
    expect(page).to have_content('Meu Perfil')
    expect(page).to have_content('Token: ABC1234')
    expect(page).to have_content('Logout')
  end
  context 'click on dashboard' do
    scenario 'and go to dashboard' do

    end
  end

  context 'click on my payment methods' do
    scenario 'and go to client payment methods' do

    end
  end

  context 'click on my profile' do
    scenario 'and go to client profile' do

    end
  end
end
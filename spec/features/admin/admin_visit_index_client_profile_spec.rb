require 'rails_helper'

feature 'admin visits index of client profile' do
  scenario 'sucessfully' do
    client1 = Client.create!(email: 'client1@test.com', password: '123456')
    client2 = Client.create!(email: 'client2@test.com', password: '123456')
    client_profile1 = ClientProfile.create!(company_name: 'A', cnpj: '111111111', manager: 'Felipe', address: 'Rua A, 1234', phone: '11-2222222', 
                                            auth_token:'123456', client: client1)
    client_profile2 = ClientProfile.create!(company_name: 'B', cnpj: '22222222', manager: 'Antonio', address: 'Rua B, 1234', phone: '11-333333', 
                                            auth_token:'987654', client: client2)
    admin = create(:admin)
    login_as(admin, scope: :admin)

    visit  admin_client_profiles_path

    expect(page).to have_content('Clientes')
    expect(page).to have_content(client_profile1.company_name)
    expect(page).to have_content(client_profile1.cnpj)
    expect(page).to have_content(client_profile1.phone)
    expect(page).to have_content(client1.email)
    expect(page).to have_content(client_profile2.company_name)
    expect(page).to have_content(client_profile2.cnpj)
    expect(page).to have_content(client_profile2.phone)
    expect(page).to have_content(client2.email)
  end

  scenario 'no registered clients' do
    admin = create(:admin)
    login_as(admin, scope: :admin)

    visit  admin_client_profiles_path

    expect(page).to have_content('Não há clientes cadastrados')

  end
end
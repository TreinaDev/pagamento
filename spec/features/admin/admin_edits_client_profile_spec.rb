require 'rails_helper'

feature 'admin edits client profile' do
  scenario 'successfully' do
    client = Client.create!(email: 'client1@test.com', password: '123456')
    client_profile = ClientProfile.create!(company_name: 'A',
                                           cnpj: '111111111',
                                           manager: 'Felipe',
                                           address: 'Rua A, 1234',
                                           phone: '11-2222222',
                                           auth_token: '123456',
                                           client: client)

    admin = create(:admin)
    login_as(admin, scope: :admin)

    visit admin_client_profiles_path
    click_on client_profile.company_name
    click_on 'Editar'
    fill_in 'CNPJ', with: '78.991.081/0001-26'
    fill_in 'Razão Social', with: 'Campus Code'
    fill_in 'Representante', with: 'Luizinho'
    fill_in 'Endereço', with: 'Av. Teste, 1000'
    fill_in 'Telefone', with: '(11)2222-9999'
    click_on 'Salvar'

    client_profile = ClientProfile.last

    expect(page).to have_content('Perfil do Cliente')
    expect(page).to have_content('78.991.081/0001-26')
    expect(page).to have_content('Campus Code')
    expect(page).to have_content('Luizinho')
    expect(page).to have_content('Av. Teste, 1000')
    expect(page).to have_content('(11)2222-9999')
    expect(page).to have_content('Perfil do cliente atualizado com sucesso')
    expect(client_profile.auth_token).not_to eq(nil)
    expect(client_profile.auth_token).to eq('123456')
  end

  scenario 'fields cant be blank' do
    client = Client.create(email: 'client1@test.com', password: '123456')
    client_profile = ClientProfile.create(company_name: 'A',
                                          cnpj: '111111111',
                                          manager: 'Felipe',
                                          address: 'Rua A, 1234',
                                          phone: '11-2222222',
                                          auth_token: '123456',
                                          client: client)

    admin = create(:admin)
    login_as(admin, scope: :admin)

    visit admin_client_profiles_path
    click_on client_profile.company_name
    click_on 'Editar'
    fill_in 'CNPJ', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'Representante', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Telefone', with: ''
    click_on 'Salvar'

    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Razão Social não pode ficar em branco')
    expect(page).to have_content('Representante não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
    expect(page).to have_content('Telefone não pode ficar em branco')
    expect(page).to have_content('Você deve corrigir todos os erros para '\
                                 'prosseguir')
  end
end

require 'rails_helper'

feature 'Admin register a new client' do
  it 'successfully' do
    admin = create(:admin)
    login_as(admin, scope: :admin)

    visit new_admin_client_profile_path

    fill_in 'CNPJ', with: '78.991.081/0001-26'
    fill_in 'Razão Social', with: 'Campos Code'
    fill_in 'Representante', with: 'Luizinho'
    fill_in 'Endereço', with: 'Av. Teste, 1000'
    fill_in 'Telefone', with: '(11)2222-9999'
    fill_in 'E-mail', with: 'cliente@teste.com'

    click_on 'Salvar'

    expect(page).to have_content('Perfil do Cliente')
    expect(page).to have_content('78.991.081/0001-26')
    expect(page).to have_content('Campos Code')
    expect(page).to have_content('Luizinho')
    expect(page).to have_content('Av. Teste, 1000')
    expect(page).to have_content('(11)2222-9999')
    expect(page).to have_content('cliente@teste.com')
    expect(page).to have_content('Cliente criado com sucesso')

    client_profile = ClientProfile.last
    expect(client_profile.auth_token).not_to eq(nil)
    expect(page).to have_content(client_profile.auth_token)
  end

  it 'fields cant be blank' do
    admin = create(:admin)
    login_as(admin, scope: :admin)

    visit new_admin_client_profile_path

    click_on 'Salvar'

    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Razão Social não pode ficar em branco')
    expect(page).to have_content('Representante não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
    expect(page).to have_content('Telefone não pode ficar em branco')
    expect(page).to have_content('E-mail não pode ficar em branco')
    expect(page).to have_content('Você deve corrigir todos os erros '\
                                 'para prosseguir')
  end
end

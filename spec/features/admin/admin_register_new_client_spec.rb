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
    fill_in 'Email', with: 'client@teste.com'

    click_on 'Criar'
    
    expect(page).to have_content('78.991.081/0001-26')
    expect(page).to have_content('Campos Code')
    expect(page).to have_content('Luizinho')
    expect(page).to have_content('Av. Teste, 1000')
    expect(page).to have_content('(11)2222-9999')
    expect(page).to have_content('client@teste.com')
  end
end
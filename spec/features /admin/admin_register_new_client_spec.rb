require 'rails_helper'

feature 'Admin register a new client' do
  it 'successfully' do
    admin = create(:admin)
    login_as(admin, scope: :admin)

    visit xxxxxx

    fill_in 'CNPJ', with: ' '
    fill_in 'Nome da Empresa', with: ''
    fill_in 'Endereço', with: 'Av. Teste, 1000'
    fill_in 'Email', with: 'client@teste.com'
    fill_in 'Senha', with: '123teste'

    click_on 'Salvar' 

    
  end
end
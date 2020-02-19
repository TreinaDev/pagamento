require 'rails_helper'

feature 'Admin register payment methods' do
  scenario 'succesfully' do
    admin = create(:admin, email: 'admin@email.com')

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Meios de pagamento'
    click_on 'Cadastrar novo meio de pagamento'
    fill_in 'Nome', with: 'Cartão de crédito'
    fill_in 'Taxa', with: 5

    click_on 'Salvar'

    expect(page).to have_content('Meio de pagamento cadastrado com sucesso!')
    expect(page).to have_content('Cartão de crédito')
    expect(page).to have_content('Taxa: 5.0%')
  end

  scenario 'and param is missing' do
    admin = create(:admin, email: 'admin@email.com')

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Meios de pagamento'
    click_on 'Cadastrar novo meio de pagamento'
    click_on 'Salvar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Taxa não pode ficar em branco')
    expect(page).to have_content('Cadastrar novo meio de pagamento')
  end
end

require 'rails_helper'

feature 'Admin register payment methods' do
  scenario 'succesfully' do
    admin = create(:admin, email: 'admin@email.com')

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Meios de pagamento'
    click_on 'Cadastrar novo meio de pagamento'
    fill_in 'Nome', with: 'Cartão de crédito'
    fill_in 'Taxa', with: 0.05
    attach_file 'Image', Rails.root.join('spec/support/mastercard.png')
    click_on 'Salvar'

    expect(page).to have_content('Meio de pagamento cadastrado com sucesso!')
    expect(page).to have_content('Meio de pagamento: Cartão de crédito')
    expect(page).to have_content('Taxa: 5.0%')
    expect(page).to have_css("img[src*='mastercard.png']")
  end

  scenario 'and param is missing' do
    admin = create(:admin, email: 'admin@email.com')

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Meios de pagamento'
    click_on 'Cadastrar novo meio de pagamento'
    click_on 'Salvar'

    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Tax can't be blank")
    expect(page).to have_content("Image can't be blank")
    expect(page).to have_content('Cadastrar novo meio de pagamento')
  end
end

require 'rails_helper'

feature 'Admin edit payment method' do
  scenario 'successfully' do
    create(:payment_method, :boleto, tax: 5)
    admin = create(:admin)

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Meios de pagamento'
    click_on 'Boleto'
    click_on 'Editar'
    fill_in 'Nome', with: 'Boleto'
    fill_in 'Taxa', with: 3
    click_on 'Salvar'

    expect(page).to have_content('Meio de pagamento atualizado com sucesso!')
    expect(page).to have_content('Boleto')
    expect(page).to have_content('Taxa: 3.0%')
  end

  scenario 'and must fill all fields' do
    create(:payment_method, :boleto, tax: 0.05)
    admin = create(:admin)

    login_as(admin, scope: :admin)
    visit root_path
    click_on 'Meios de pagamento'
    click_on 'Boleto'
    click_on 'Editar'
    fill_in 'Nome', with: nil
    fill_in 'Taxa', with: nil
    click_on 'Salvar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Taxa não pode ficar em branco')
  end

  scenario 'and must be and admin' do
    client = create(:client)

    login_as(client, scope: :client)

    expect(page).not_to have_link('Editar')
  end
end

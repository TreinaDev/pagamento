require 'rails_helper'

feature 'Admin register payment methods' do
  context 'Register general data' do
    scenario 'succesfully' do
      visit root_path
      click_on 'Meios de pagamento'
      click_on 'Cadastrar novo meio de pagamento'

      fill_in 'Taxa', with: 0.05
      select 'Cartão de Crédito', from: 'Meios de pagamento'
      click_on 'Salvar'

      expect(page).to have_content('Meio de pagamento cadastrado com sucesso!')
      expect(page).to have_content('Taxa: 5%')
      expect(page).to have_content('Meio de pagamento: Cartão de Crédito')
    end
  end

  context 'register credit card' do
    xscenario 'succesfully' do
      visit root_path
      click_on 'Meios de pagamento'
      click_on 'Cartões de crédito'
      click_on 'Cadastrar nova bandeira'

      fill_in 'Tipo', with


    end
  end
end
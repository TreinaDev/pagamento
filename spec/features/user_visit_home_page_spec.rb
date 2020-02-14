require 'rails_helper'

feature 'User visit home page' do
  context 'as non registered user' do
    scenario 'and view nav options' do
      visit root_path

      expect(page).to have_content('Nome da companhia aqui')
      expect(page).to have_content('Quem Somos')
      expect(page).to have_content('O que fazemos?')
      expect(page).to have_content('Meios de pagamento')
      expect(page).to have_content('Login')
    end
    scenario 'and not view admin options' do
      visit root_path

      expect(page).not_to have_content('Clientes')
      expect(page).not_to have_content('Cadastrar novo cliente')
      expect(page).not_to have_content('Logout')
    end
  end

  context 'as admin' do
    scenario 'and view nav options' do
      admin = create(:admin)

      login_as admin, scope: :admin
      visit root_path

      expect(page).to have_content('Nome da companhia aqui')
      expect(page).to have_content('Clientes')
      expect(page).to have_content('Cadastrar novo cliente')
      expect(page).to have_content('Meios de pagamento')
      expect(page).to have_content('Logout')
    end

    scenario 'and do not view non registered user options' do
      admin = create(:admin)

      login_as admin, scope: :admin
      visit root_path

      expect(page).not_to have_content('Quem Somos')
      expect(page).not_to have_content('O que fazemos?')
      expect(page).not_to have_content('Login')
    end
  end
end

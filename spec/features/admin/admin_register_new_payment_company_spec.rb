require 'rails_helper'
  context 'admin register payment company' do
    it 'success' do
      #debit = create(:payment_method, :debit)

      visit new_payment_company_path
      fill_in 'Bandeira/Banco', with: 'Mastercard'
      attach_file 'Image', Rails.root.join('spec/support/mastercard.png')
      click_on 'Salvar'

      expect(page).to have_content('Mastercard')
      expect(page).to have_css("img[src*='mastercard.png']")

      payment_company = PaymentCompany.last

      expect(payment_company.payment_method).to eq(debit) 

    end
  end
require 'rails_helper'
context 'admin register payment company' do
  it 'success' do
    debit = create(:payment_method, :debit, name: 'Débito')

    admin = create(:admin)
    login_as(admin, scope: :admin)

    visit root_path
    click_on 'Meios de pagamento'
    click_on 'Vincular Empresas'

    fill_in 'Bandeira/Banco/Serviço', with: 'Mastercard'
    attach_file 'Image', Rails.root.join('spec/support/mastercard.png')
    select 'Débito', from: 'Metodo de pagamento'
    click_on 'Salvar'

    expect(page).to have_content('Mastercard')
    expect(page).to have_css("img[src*='mastercard.png']")
    expect(page).to have_content('Débito')

    payment_company = PaymentCompany.last

    expect(payment_company.payment_method).to eq(debit)
  end

  it 'and try to create a payment company without fill all fields' do
    create(:payment_method, :debit, name: 'Débito')

    admin = create(:admin)
    login_as(admin, scope: :admin)

    visit new_admin_payment_company_path
    click_on 'Salvar'

    expect(page).to have_content(
      'Bandeira/Banco/Serviço não pode ficar em branco'
    )
    expect(page).to have_content(
      'Imagem não pode ficar em branco'
    )
  end
end

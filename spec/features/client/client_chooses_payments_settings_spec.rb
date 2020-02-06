require 'rails_helper'

feature 'client chooses payments settings' do
  scenario 'sucessfully' do
    client = create(:client)
    payment_method = create(:payment_method, :debit)
    payment_method1 = create(:payment_method, :digital_transfer)
    payment_method2 = create(:payment_method, :credit)

    login_as(client, scope: :client)
    visit client_dashboard_index_path
    click_on 'Meios de Pagamento'
    click_on 'Configure seus Meios de Pagamento'

    select payment_method1.name, from: 'Tipo de pagamento'
    select 10, from: 'Número de parcelas'
    fill_in 'Juros', with: 0.6
    click_on 'Salvar'

    expect(page).to have_content(payment_method1.name)
    expect(page).to have_content('Número de parcelas: 10x')
    expect(page).to have_content('Juros: 0.6%')
    expect(page).to have_css("img[src*='paypal.png']")
  end
end
require 'rails_helper'

feature 'client chooses payments settings' do
  scenario 'sucessfully' do
    client = create(:client)
    create(:client_profile, client: client)
    create(:payment_method, :debit)
    payment_method1 = create(:payment_method, :digital_transfer)
    create(:payment_company, payment_method: payment_method1)
    create(:payment_method, :credit)

    login_as(client, scope: :client)
    visit client_dashboard_index_path
    click_on 'Meios de Pagamento'
    click_on 'Configure seus Meios de Pagamento'

    select payment_method1.name, from: 'Tipo de pagamento'
    fill_in 'Número de parcelas', with: 10
    fill_in 'Juros', with: 6
    fill_in 'Desconto', with: 0
    click_on 'Salvar'

    expect(page).to have_content('Paypal')
    expect(page).to have_content('Número de parcelas: 10x')
    expect(page).to have_content('Juros: 6.0%')
    expect(page).to have_content('Desconto: 0.0%')
  end

  scenario 'and must not be blank' do
    client = create(:client)
    create(:client_profile, client: client)
    create(:payment_method, :debit)

    login_as(client, scope: :client)
    visit client_dashboard_index_path
    click_on 'Meios de Pagamento'
    click_on 'Configure seus Meios de Pagamento'

    click_on 'Salvar'

    expect(page).to have_content('Parcelas não pode ficar em branco')
    expect(page).to have_content('Taxa de Juros não pode ficar em branco')
    expect(page).to have_content('Desconto não pode ficar em branco')
  end
end

require 'rails_helper'

describe 'Client view all his payment settings' do
  scenario 'sucessfully' do
    client = create(:client)
    client_profile = create(:client_profile, company_name: 'Campus',
                                             cnpj: '12345678901234',
                                             auth_token: 'ABC321466',
                                             client: client)
    payment_method = create(:payment_method, name: 'Boleto')
    create(:payment_setting, payment_method: payment_method,
                             installments: 0,
                             interest_rate: 0,
                             discount: 10,
                             client_profile: client_profile)

    login_as client, scope: :client
    visit root_path
    click_on 'Meus meios de pagamento'

    expect(page).to have_content('Boleto')
  end
  scenario 'and view payment settings details' do
    client = create(:client)
    client_profile = create(:client_profile, company_name: 'Campus',
                                             cnpj: '12345678901234',
                                             auth_token: 'ABC321466',
                                             client: client)
    payment_method = create(:payment_method, name: 'Boleto')
    create(:payment_setting, payment_method: payment_method,
                             installments: 0,
                             interest_rate: 0,
                             discount: 10,
                             client_profile: client_profile)

    login_as client, scope: :client
    visit root_path
    click_on 'Meus meios de pagamento'
    click_on 'Boleto'

    expect(page).to have_content('Boleto')
    expect(page).to have_content('Número de parcelas: 0x')
    expect(page).to have_content('Juros: 0.0%')
    expect(page).to have_content('Desconto: 10.0%')
  end
end

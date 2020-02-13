require 'rails_helper'

describe 'API sends payment methods' do
  it 'successfully' do
    client = create(:client)
    client_profile = create(:client_profile, auth_token: 'ABC1234567', client: client)
    payment_method = create(:payment_method)
    payment_settings = create(:payment_setting, client_profile: client_profile,
                               payment_method: payment_method)

    get api_v1_payment_methods_path(auth_token: client_profile.auth_token)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(:ok)
    expect(json[:data][0][:name]).to include('Cartão de Debito')
  end

  it 'successfully and render correct json' do
    client1 = create(:client)
    client2 = create(:client, email: 'teste@teste.com')
    client_profile1 = create(:client_profile, auth_token: 'ABC1234567', client: client1)
    client_profile2 = create(:client_profile, auth_token: 'ABCDE12345', client: client2)
    payment_method1 = create(:payment_method, :debit)
    payment_method2 = create(:payment_method, :boleto)
    create(:payment_setting, client_profile: client_profile1,
                               payment_method: payment_method1)
    create(:payment_setting, client_profile: client_profile2,
                                payment_method: payment_method2)

    get api_v1_payment_methods_path(auth_token: client_profile1.auth_token)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(:ok)
    expect(json[:data][0][:name]).to include('Débito em Conta')
    expect(json[:data]).not_to include('Boleto')
  end

  it 'successfully and render correct json' do
    client1 = create(:client)
    client_profile1 = create(:client_profile, auth_token: 'ABC1234567', client: client1)
    payment_method1 = create(:payment_method, :debit)
    payment_method2 = create(:payment_method, :boleto)
    payment_settings1 = create(:payment_setting, client_profile: client_profile1,
                               payment_method: payment_method1)
    payment_settings2 = create(:payment_setting, client_profile: client_profile1,
                                payment_method: payment_method2)

    get api_v1_payment_methods_path(auth_token: client_profile1.auth_token)

    json = JSON.parse(response.body, symbolize_names: true)
     
    expect(response).to have_http_status(:ok)
    expect(json[:data][0][:name]).to include('Débito em Conta')
    expect(json[:data][1][:name]).to include('Boleto')
  end

  it 'successfully render payment companies' do
    image_path = Rails.root.join('spec/support/mastercard.png')
    client = create(:client)
    client_profile = create(:client_profile, auth_token: 'ABC1234567', client: client)
    payment_method = create(:payment_method, name: 'Cartão de Débito')
    company = create(:payment_company, payment_method: payment_method)
    create(:payment_setting, client_profile: client_profile,
                              payment_method: payment_method)

    get api_v1_payment_methods_path(auth_token: client_profile.auth_token)

    json = JSON.parse(response.body, symbolize_names: true)
    
    pp json

    expect(response).to have_http_status(:ok)
    expect(json[:data][0][:name]).to include('Cartão de Débito')
    expect(json[:data][0][:payment_company][:image]).to include(company.image)
  end
end
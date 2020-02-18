require 'rails_helper'

describe 'API sends payment methods' do
  it 'successfully' do
    client = create(:client)
    client_profile = create(:client_profile, auth_token: 'ABC1234567',
                                             client: client)
    payment_method = create(:payment_method)
    create(:payment_company, payment_method: payment_method)
    create(:payment_setting, client_profile: client_profile,
                             payment_method: payment_method)

    get "/api/v1/client/#{client_profile.auth_token}/payment_methods"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(:ok)
    expect(json[:payment_methods][0][:name]).to include('Cartão de Debito')
  end

  it 'successfully and render correct json' do
    client1 = create(:client)
    client2 = create(:client, email: 'teste@teste.com')
    client_profile1 = create(:client_profile, auth_token: 'ABC1234567',
                                              client: client1)
    client_profile2 = create(:client_profile, auth_token: 'ABCDE12345',
                                              client: client2)
    payment_method1 = create(:payment_method, :debit)
    payment_method2 = create(:payment_method, :boleto)
    create(:payment_company, payment_method: payment_method1)
    create(:payment_company, payment_method: payment_method2)
    create(:payment_setting, client_profile: client_profile1,
                             payment_method: payment_method1)
    create(:payment_setting, client_profile: client_profile2,
                             payment_method: payment_method2)

    get "/api/v1/client/#{client_profile1.auth_token}/payment_methods"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(:ok)
    expect(json[:payment_methods][0][:name]).to include('Débito em Conta')
    expect(json).not_to include('Boleto')
  end

  it 'successfully and render more than one payment method' do
    client1 = create(:client)
    client_profile1 = create(:client_profile, auth_token: 'ABC1234567',
                                              client: client1)
    payment_method1 = create(:payment_method, :debit)
    payment_method2 = create(:payment_method, :boleto)
    create(:payment_company, payment_method: payment_method1)
    create(:payment_company, payment_method: payment_method2)
    create(:payment_setting, client_profile: client_profile1,
                             payment_method: payment_method1)
    create(:payment_setting, client_profile: client_profile1,
                             payment_method: payment_method2)

    get "/api/v1/client/#{client_profile1.auth_token}/payment_methods"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(:ok)
    expect(json[:payment_methods][0][:name]).to include('Débito em Conta')
    expect(json[:payment_methods][1][:name]).to include('Boleto')
  end

  it 'successfully render payment companies' do
    client = create(:client)
    client_profile = create(:client_profile, auth_token: 'ABC1234567',
                                             client: client)
    payment_method = create(:payment_method, name: 'Cartão de Débito')
    company = create(:payment_company, payment_method: payment_method)
    create(:payment_setting, client_profile: client_profile,
                             payment_method: payment_method)

    get "/api/v1/client/#{client_profile.auth_token}/payment_methods"

    json = JSON.parse(response.body, symbolize_names: true)
    imagem = json[:payment_methods][0][:payment_companies][0][:image]
    expect(response).to have_http_status(:ok)
    expect(json[:payment_methods][0][:name]).to include('Cartão de Débito')
    expect(imagem).to include(rails_blob_path(company.image))
  end

  it 'successfully render more than one payment company' do
    client = create(:client)
    client_profile = create(:client_profile, auth_token: 'ABC1234567',
                                             client: client)
    payment_method = create(:payment_method, name: 'Cartão de Débito')
    company1 = create(:payment_company, payment_method: payment_method)
    company2 = create(:payment_company, name: 'Visa',
                                        payment_method: payment_method)
    create(:payment_setting, client_profile: client_profile,
                             payment_method: payment_method)

    get "/api/v1/client/#{client_profile.auth_token}/payment_methods"

    json = JSON.parse(response.body, symbolize_names: true)
    image1 = json[:payment_methods][0][:payment_companies][0][:image]
    image2 = json[:payment_methods][0][:payment_companies][1][:image]

    expect(response).to have_http_status(:ok)
    expect(json[:payment_methods][0][:name]).to include('Cartão de Débito')
    expect(image1).to include(rails_blob_path(company1.image))
    expect(image2).to include(rails_blob_path(company2.image))
  end

  it 'return error 404 if payment settings not found' do
    client = create(:client)
    client_profile = create(:client_profile, auth_token: 'ABC1234567',
                                             client: client)
    payment_method = create(:payment_method, name: 'Cartão de Débito')
    create(:payment_company, payment_method: payment_method)

    get "/api/v1/client/#{client_profile.auth_token}/payment_methods"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(404)
    expect(json[:message]).to include('Não há meio de pagamentos cadastrados')
  end

  it 'dont send payment method without payment company' do
    client = create(:client)
    client_profile = create(:client_profile, auth_token: 'ABC1234567',
                                             client: client)
    payment_method = create(:payment_method, name: 'Cartão de Débito')
    create(:payment_setting, client_profile: client_profile,
                             payment_method: payment_method)

    get "/api/v1/client/#{client_profile.auth_token}/payment_methods"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(200)
    expect(json).to eq(payment_methods: [])
  end
end

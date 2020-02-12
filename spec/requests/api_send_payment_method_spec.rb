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
    expect(json[:data]).to include('Cartão de Debito')
  end
end
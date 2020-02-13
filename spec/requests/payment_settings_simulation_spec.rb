require 'rails_helper'

describe 'Payment Settings' do
  context 'simulation' do
    it 'successfully' do
      client = create(:client)
      profile = create(:client_profile, client: client)
      payment_method = create(:payment_method)
      payment_setting = create(:payment_setting, client_profile: profile, 
                                payment_method: payment_method)
      
      get "/api/v1/client/#{profile.auth_token}/transaction_simulation?value=1000"
      puts response.body
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[0].name).to eq(payment_method.name) 

    end
  end
end
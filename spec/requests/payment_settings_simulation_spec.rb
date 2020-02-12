require 'rails_helper'

describe 'Payment Settings' do
  context 'simulation' do
    it 'successfully' do
      client = create(:client)
      profile = create(:client_profile, client: client)
      payment_method = create(:payment_method)
      payment_setting = create(:payment_setting, client_profile: profile, 
                                payment_method: payment_method)
      
      get "/api/v1/client/#{profile.token}/transaction_simulation?value=1000"

    end
  end
end
require 'rails_helper'

describe 'Payment Settings' do
  context 'simulation' do
    it 'successfully' do
      client = create(:client)
      profile = create(:client_profile, client: client)
      payment_method = create(:payment_method, name: 'Cartão de Debito')
      payment_setting = create(:payment_setting, client_profile: profile,
                                payment_method: payment_method, installments: 2)
      
      get "/api/v1/client/#{profile.auth_token}/transaction_simulation?value=1000"
      
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[0][:name]).to eq(payment_method.name)
      expect(json[0][:value]).to eq("1000.0")
      expect(json[0][:installments]).to eq(payment_setting.installments)
      expect(json[0][:one_shot]).to eq("900.0")
      expect(json[0][:total_value]).to eq("1500.0")
      expect(json[0][:installment_value]).to eq("750.0")
    end

    it 'try to send more than one payment settings' do
      client_first = create(:client, email: 'cliente_1@teste.com')
      profile_first = create(:client_profile, client: client_first,
                             company_name: 'Empresa A')

      client_second = create(:client, email: 'test_sa@teste.com')
      profile_second = create(:client_profile, client: client_second,
                              company_name: 'Empresa B', auth_token: 'WAFsdfarADSaf')
      
      payment_method_one = create(:payment_method, name: 'Cartão de Debito')
      payment_method_two = create(:payment_method, name: 'Boleto')
      payment_method_three = create(:payment_method, name: 'Paypal')

      payment_setting_one = create(:payment_setting, client_profile: profile_first,
                                   payment_method: payment_method_one, discount: 0.05,
                                   installments: 2, interest_rate: 0.2)
      payment_setting_two = create(:payment_setting, client_profile: profile_first,
                                   payment_method: payment_method_two, discount: 0.1,
                                   installments: 5, interest_rate: 0.3)
      payment_setting_three = create(:payment_setting, client_profile: profile_second,
                                     payment_method: payment_method_three)

      get "/api/v1/client/#{profile_first.auth_token}/transaction_simulation?value=2000"
      
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json.count).to eq(2)

      expect(json[0][:name]).to eq(payment_method_one.name)
      expect(json[0][:value]).to eq("2000.0")
      expect(json[0][:installments]).to eq(payment_setting_one.installments)
      expect(json[0][:one_shot]).to eq("1900.0")
      expect(json[0][:total_value]).to eq("2400.0")
      expect(json[0][:installment_value]).to eq("1200.0")

      expect(json[1][:name]).to eq(payment_method_two.name)
      expect(json[1][:value]).to eq("2000.0")
      expect(json[1][:installments]).to eq(payment_setting_two.installments)
      expect(json[1][:one_shot]).to eq("1800.0")
      expect(json[1][:total_value]).to eq("2600.0")
      expect(json[1][:installment_value]).to eq("520.0")
    end
  end
end
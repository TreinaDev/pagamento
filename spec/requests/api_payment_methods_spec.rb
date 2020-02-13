require 'rails_helper'

describe 'Api payment methods' do
  context 'create' do
    it 'successfully' do
      payment_method = create(:payment_method, :debit)
      client = create(:client)
      client_profile = create(:client_profile, client: client)

      post api_v1_payment_methods_path, params: { client_token: client_profile.auth_token,
                                                  order_value: 500.00,
                                                  order_id: 24,
                                                  payment_method_id: payment_method.id}

      expect(response).to have_http_status(:created)
      order = Order.last
      expect(order.order_id).to eq(24)
      expect(order.client_token).to eq(client_profile.auth_token)
    end
  end
end

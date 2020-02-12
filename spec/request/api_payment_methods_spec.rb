require 'rails_helper'

describe 'Api payment methods' do
  context 'create' do
    it 'successfully' do
      payment_method = create(:payment_method, :debit)
      client = create(:client)

      expect{post api_v1_payment_methods_path, 
        params: {client_token: client.token,
                  value: 500.00,
                  id: id,
                  payment_method: payment_method }}.to change(Order, :count).by(1)
                  
      expect(response).to have_http_status(:created)
      order = Order.last 
      expect(order.id).to eq('24')
      expect(order.client_token).to eq('client.token')
    end
  end
end
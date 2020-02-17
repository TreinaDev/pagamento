require 'rails_helper'

describe 'Order create via API POST' do
  context 'create' do
    it 'successfully' do
      create(:payment_method, :debit)
      client = create(:client)
      client_profile = create(:client_profile, client: client)

      expect do
        post "/api/v1/client/#{client_profile.auth_token}/order?"\
             'order_value=500&order_id=24&payment_method_id=1'
      end.to change(Order, :count).by(1)

      expect(response).to have_http_status(:created)
      order = Order.last
      expect(order.order_id).to eq(24)
      expect(order.client_token).to eq(client_profile.auth_token)
    end

    it 'and must dont have a registered client' do
      post "/api/v1/client/'AhjdbejbdHAdghje'/order?"\
            'order_value=500&order_id=24&payment_method_id=1'

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:precondition_failed)
      expect(json[:message]).to include('Cliente não registrado')
    end

    it 'and must send all params' do
      create(:payment_method, :debit)
      client = create(:client)
      client_profile = create(:client_profile, client: client)

      post "/api/v1/client/#{client_profile.auth_token}/order?"\
             'order_id=24&payment_method_id=1'

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:precondition_failed)
      expect(json[:message]).to include('Valor do Pedido não pode ficar em '\
                                        'branco')
    end
  end
end

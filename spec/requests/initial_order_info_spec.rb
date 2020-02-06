require 'rails_helper'

RSpec.describe Order do
  describe 'System receive initial order info' do
    it 'successfuly' do
      Order.all

      order = Order.find(2)

      expect(order.order_id).to eq 2
      expect(order.client_token).to eq 'DEF4927489vjf'
      expect(order.order_value).to eq 10_000
    end
  end
end

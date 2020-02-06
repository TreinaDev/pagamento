class Order
  attr_reader :order_id, :client_token, :order_value
  def initialize(order_id: order_id, client_token: client_token, 
                 order_value: order_value)
    @order_id = order_id
    @client_token = client_token
    @order_value = order_value
  end

  def self.all
    [
      new(order_id: 1, client_token: 'ABC1235712ysf', order_value: 4000),
      new(order_id: 2, client_token: 'DEF4927489vjf', order_value: 10_000),
      new(order_id: 3, client_token: 'GHI4897324kjn', order_value: 500)
    ]
  end

  def self.find(order_id)
    @order = all.detect { |order| order.order_id == order_id }
  end
end

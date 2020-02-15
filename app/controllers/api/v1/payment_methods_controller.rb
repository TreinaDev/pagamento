class Api::V1::PaymentMethodsController < Api::V1::ApiController
  def create
    client_profile = ClientProfile.find_by(auth_token: params[:client_token])
    payment_method = PaymentMethod.find(params[:payment_method_id])

    order = Order.new(client_token: client_profile.auth_token,
                      order_id: params[:order_id],
                      order_value: params[:order_value],
                      client_profile_id: client_profile.id,
                      payment_method_id: payment_method.id)

    order.save!

    render json: order, status: :created
end
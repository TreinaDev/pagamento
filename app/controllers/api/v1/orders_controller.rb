module Api
  module V1
    class OrdersController < ApiController
      def create
        client_profile = ClientProfile.find_by(auth_token:
                                                params[:client_token])

        order = client_profile.orders.new(order_params)
        
        if order.save!
          render json: {order: order, client: order.client_profile,
                        payment_method: order.payment_method}, status: :created
        else
          render json: 'Transação recusada', status: :precondition_failed
        end
      end

      private

      def order_params
        params.permit(:client_token, :order_id, :order_value,
                      :payment_method_id)
      end
    end
  end
end

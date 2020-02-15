module Api
  module V1
    class OrdersController < ApiController
      def create
        client_profile = ClientProfile.find_by(auth_token:
                                                params[:client_token])

        order = client_profile.orders.new(order_params)

        order.save!

        render json: order, status: :created
      end

      private

      def order_params
        params.permit(:client_token, :order_id, :order_value,
                      :payment_method_id, :client_profile_id)
      end
    end
  end
end

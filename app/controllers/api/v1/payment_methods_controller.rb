module Api
  module V1
    class PaymentMethodsController < ActionController::API

      def index
        @client = ClientProfile.find_by(auth_token: params[:auth_token])
        render json: {data: @client.payment_methods}, status: 200
      end
    
    end
  end
end

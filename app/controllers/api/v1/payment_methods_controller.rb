module Api
  module V1
    class PaymentMethodsController < ActionController::API
      before_action :verify_payment_settings

      def index
        @client = ClientProfile.find_by(auth_token: params[:token])
        @payment_methods = @client.active_payment_methods
        @companies = PaymentCompany.where(payment_method: @payment_methods)
      end

      private

      def verify_payment_settings
        @client = ClientProfile.find_by(auth_token: params[:token])
        @payment_settings = @client.payment_settings
        return unless @payment_settings.empty?

        render json: { message: 'Não há meio de pagamentos cadastrados' },
               status: :not_found
      end
    end
  end
end

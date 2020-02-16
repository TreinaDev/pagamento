module Api
  module V1
    class PaymentMethodsController < ActionController::API
      before_action :verify_payment_settings

      def index
        @companies = PaymentCompany.where(payment_method: @payment_methods)
      end

      private

      def verify_payment_settings
        @client = ClientProfile.find_by(auth_token: params[:auth_token])
        @payment_methods = @client.payment_methods
        if @payment_methods == []
          render json: { message: 'Não há meio de pagamentos cadastrados' },
                 status: :not_found
        elsif PaymentCompany.where(payment_method: @payment_methods).empty?
          render json: { message: 'Não há companhias cadastradas' },
                 status: :not_found
        end
      end
    end
  end
end

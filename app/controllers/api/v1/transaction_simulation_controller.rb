module Api
  module V1
    class TransactionSimulationController < ApiController
      def simulation
        profile = ClientProfile.find_by(auth_token: params[:token])

        if profile.present?
          payment_options = payment_options(profile, params[:value])

          render json: payment_options, status: :ok
        else
          render json: { 'message': 'Perfil não encontrado' },
                 status: :not_found
        end
      end

      def payment_options(profile, value)
        payment_array = []
        profile.payment_settings.each do |setting|
          transaction = Transaction.new(setting.payment_method.name,
                                        value, setting.installments)

          transaction.calculate(setting.discount, setting.interest_rate)
          payment_array << transaction.as_json
        end
        payment_array
      end
    end
  end
end

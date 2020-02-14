module Api
  module V1
    class TransactionSimulationController < ApiController

      def simulation
        token = params[:token]
        value = params[:value]

        profile = ClientProfile.find_by(auth_token: token)

        if profile.present?

          array_payment = []
          profile.payment_settings.each do |setting|
            transaction = Transaction.new(setting.payment_method.name, value,
                                          setting.installments)
  
            transaction.calculate(setting.discount, setting.interest_rate)
            array_payment << transaction.as_json
          end

          render json: array_payment, status: :ok
        else
          #tratar erro
        end

      end

    end
  end
end

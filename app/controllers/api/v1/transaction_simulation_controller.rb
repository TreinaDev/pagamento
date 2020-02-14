module Api
  module V1
    class TransactionSimulationController < ApiController

      def simulation
        token = params[:token]
        value = params[:value]

        profile = ClientProfile.find_by(auth_token: token)

        if profile.present?

          
          profile.payment_settings.each do |setting|
            transaction = Transaction.new(setting.payment_method.name)
            puts transaction.as_json
          end

          
        else
          #tratar erro
        end
        
      end

    end
  end
end

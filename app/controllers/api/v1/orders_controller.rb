module Api
  module V1
    class OrdersController < ApiController
      rescue_from ActiveRecord::RecordNotFound, with: :client_invalid
      rescue_from ActiveRecord::RecordInvalid, with: :order_invalid

      def create
        client = ClientProfile.find_by!(auth_token: params[:client_token])
        order = client.orders.new(order_params)
        order.calculate_client_value if order.valid?
        order.save!
        render json: { "message": 'Pagamento efetivado com sucesso',
                       order: order.as_json(except:
                        %i[client_token created_at updated_at]) },
               status: :created
      end

      private

      def client_invalid
        render json: { "message": 'Cliente não registrado' },
               status: :precondition_failed
      end

      def order_invalid(exception)
        render json: { "message": exception.record.errors.full_messages },
               status: :precondition_failed
      end

      def order_params
        params.permit(:client_token, :order_id, :order_value,
                      :payment_method_id, :order_installments,
                      :order_installments_value)
      end
    end
  end
end

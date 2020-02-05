class PaymentMethodsController < ApplicationController
  def index
    @payment_methods = PaymentMethod.all
  end

  def show
    @payment_method = PaymentMethod.find(params[:id])
  end

  def new
    @payment_method = PaymentMethod.new
  end

  def create
    @payment_method = PaymentMethod.new(payment_method_params)
    @payment_method.save
    flash[:notice] = 'Meio de pagamento cadastrado com sucesso!'
    redirect_to @payment_method
  end


  private

  def payment_method_params
    params.require(:payment_method).permit(:name, :tax, :image)
  end

end

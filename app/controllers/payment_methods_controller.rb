class PaymentMethodsController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create edit update]

  def index
    @payment_methods = PaymentMethod.all
  end

  def show
    @payment_method = PaymentMethod.find(params[:id])
    @payment_companies = PaymentCompany.where(payment_method: @payment_method)
  end

  def new
    @payment_method = PaymentMethod.new
  end

  def create
    @payment_method = PaymentMethod.new(payment_method_params)

    if @payment_method.save
      flash[:notice] = 'Meio de pagamento cadastrado com sucesso!'
      redirect_to @payment_method
    else
      render :new
    end
  end

  def edit
    @payment_method = PaymentMethod.find(params[:id])
  end

  def update
    @payment_method = PaymentMethod.find(params[:id])
    if @payment_method.update(payment_method_params)
      flash[:notice] = 'Meio de pagamento atualizado com sucesso!'
      redirect_to @payment_method
    else
      render :edit
    end
  end

  private

  def payment_method_params
    params.require(:payment_method).permit(:name, :tax, :image)
  end
end

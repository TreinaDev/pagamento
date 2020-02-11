class PaymentSettingsController < ApplicationController
  def show
    @payment_setting = PaymentSetting.find(params[:id])
  end
  
  def new
    @payment_methods = PaymentMethod.all
    @payment_setting = PaymentSetting.new
  end

  def create
    @payment_setting = PaymentSetting.new(payment_settings_params)
    @client = current_client
    @payment_setting.client_profile = @client.client_profile
    if @payment_setting.save
      redirect_to @payment_setting
    else
      @payment_methods = PaymentMethod.all
      render :new
    end
    

  end

  private

  def payment_settings_params
    params.require(:payment_setting).permit(:discount, :interest_rate,
                                             :installments, :client_profile_id,
                                             :payment_method_id)
  end
end
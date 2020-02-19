class PaymentSettingsController < ApplicationController
  def index
    @payment_settings = PaymentSetting.where(client_profile_id: current_client)
  end

  def show
    @payment_setting = PaymentSetting.find(params[:id])
  end

  def new
    @payment_methods = PaymentMethod.all
    @payment_companies = PaymentCompany.all
    @payment_setting = PaymentSetting.new
  end

  def create
    @payment_setting = PaymentSetting.new(payment_settings_params)
    @client = current_client
    @payment_setting.client_profile = @client.client_profile
    return redirect_to @payment_setting if @payment_setting.save

    @payment_companies = PaymentCompany.all
    @payment_methods = PaymentMethod.all
    render :new
  end

  private

  def payment_settings_params
    params.require(:payment_setting).permit(:discount, :interest_rate,
                                            :installments, :client_profile_id,
                                            :payment_method_id)
  end
end

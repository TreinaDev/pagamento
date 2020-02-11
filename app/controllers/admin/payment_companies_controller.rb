class Admin
  class PaymentCompaniesController < ApplicationController
    before_action :authenticate_admin!, only: %i[new create]

    def new
      @payment_company = PaymentCompany.new
      @payment_methods = PaymentMethod.all
    end

    def create
      @payment_company = PaymentCompany.new(params.require(:payment_company)
                                                  .permit(:name, :image,
                                                          :payment_method_id))

      if @payment_company.save
        redirect_to admin_payment_company_path(@payment_company),
                    notice: t('.success')
      else
        @payment_methods = PaymentMethod.all
        render :new
      end
    end

    def show
      @payment_company = PaymentCompany.find(params[:id])
    end
  end
end

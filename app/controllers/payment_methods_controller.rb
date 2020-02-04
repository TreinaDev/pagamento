class PaymentMethodsController < ApplicationController
  def index
    @payments = PaymentMethod.all
  end
end
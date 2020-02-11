class AddReferencesPaymentMethodToPaymentCompany < ActiveRecord::Migration[6.0]
  def change
    add_reference :payment_companies, :payment_method, foreign_key: true
  end
end

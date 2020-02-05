class AddTaxToPaymentMethod < ActiveRecord::Migration[6.0]
  def change
    add_column :payment_methods, :tax, :float
  end
end

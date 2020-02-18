class ChangeColumnTaxToDecimal < ActiveRecord::Migration[6.0]
  def change
    change_column :payment_methods, :tax, :decimal
  end
end

class AddInstallmentsToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :client_value, :decimal
    add_column :orders, :order_installments, :integer
    add_column :orders, :order_installments_value, :decimal
  end
end

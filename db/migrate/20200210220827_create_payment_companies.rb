class CreatePaymentCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_companies do |t|
      t.string :name

      t.timestamps
    end
  end
end

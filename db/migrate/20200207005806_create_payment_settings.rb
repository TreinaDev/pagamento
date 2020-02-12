class CreatePaymentSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_settings do |t|
      t.references :client_profile, null: false, foreign_key: true
      t.references :payment_method, null: false, foreign_key: true
      t.decimal :discount
      t.decimal :interest_rate
      t.integer :installments

      t.timestamps
    end
  end
end

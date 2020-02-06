class AddAuthTokenToClientProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :client_profiles, :auth_token, :string
    add_index :client_profiles, :auth_token, unique: true
  end
end

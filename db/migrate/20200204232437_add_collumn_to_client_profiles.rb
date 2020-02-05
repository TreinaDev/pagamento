class AddCollumnToClientProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :client_profiles, :cnpj, :string
    add_column :client_profiles, :company_name, :string
    add_column :client_profiles, :manager, :string
    add_column :client_profiles, :address, :string
    add_column :client_profiles, :phone, :string
  end
end

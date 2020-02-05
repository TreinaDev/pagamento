class RemoveNameFromClientProfiles < ActiveRecord::Migration[6.0]
  def change

    remove_column :client_profiles, :name, :string
  end
end

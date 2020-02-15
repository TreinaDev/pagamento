class RemoveEmailFieldFromClientProfile < ActiveRecord::Migration[6.0]
  def change

    remove_column :client_profiles, :email, :string
  end
end

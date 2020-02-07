class ClientProfile < ApplicationRecord
  belongs_to :client
  has_secure_token :auth_token
  has_many :payment_settings
end

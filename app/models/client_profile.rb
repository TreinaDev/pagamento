class ClientProfile < ApplicationRecord
  belongs_to :client
  has_secure_token :auth_token
end

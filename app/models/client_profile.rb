class ClientProfile < ApplicationRecord
  belongs_to :client
  has_secure_token :auth_token
  has_many :payment_settings, dependent: :destroy
  has_many :payment_methods, through: :payment_settings
  accepts_nested_attributes_for :client
  validates :cnpj, :company_name, :manager, :address, :phone, presence: true
end

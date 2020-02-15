class ClientProfile < ApplicationRecord
  belongs_to :client

  has_many :payment_settings, dependent: :destroy
  has_many :payment_methods, through: :payment_settings

  has_secure_token :auth_token
  accepts_nested_attributes_for :client
  validates_associated :client

  validates :cnpj, :company_name, presence: true
end

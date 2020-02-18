class ClientProfile < ApplicationRecord
  belongs_to :client

  has_many :payment_settings, dependent: :destroy
  has_many :payment_methods, through: :payment_settings

  has_secure_token :auth_token
  accepts_nested_attributes_for :client
  has_many :orders, dependent: :destroy
  validates :cnpj, :company_name, :manager, :address, :phone, presence: true

  validates_associated :client

  def active_payment_methods
    payment_methods.joins(:payment_companies)
                   .where.not(payment_companies: { payment_method_id: nil })
  end
end

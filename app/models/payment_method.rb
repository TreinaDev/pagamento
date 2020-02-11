class PaymentMethod < ApplicationRecord
  validates :name, :tax, presence: true
  has_many :payment_companies, dependent: :destroy
end

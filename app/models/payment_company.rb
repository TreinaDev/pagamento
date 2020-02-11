class PaymentCompany < ApplicationRecord
  validates :name, :image, presence: true
  has_one_attached :image
  belongs_to :payment_method
end

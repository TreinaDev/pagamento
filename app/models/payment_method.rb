class PaymentMethod < ApplicationRecord
  validates :name, :tax, :image, presence: true
  has_one_attached :image
end

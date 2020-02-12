class Order < ApplicationRecord
  belongs_to :clients
  belongs_to :payment_methods
end

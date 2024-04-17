class OrderItemBackup < ApplicationRecord
  validates :product_id, presence: true

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  validates :tax_rate, presence: true, inclusion: { in: 0..1 }
end

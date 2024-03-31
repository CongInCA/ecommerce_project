class AddTotalPriceWithTaxToOrderItems < ActiveRecord::Migration[7.1]
  def change
    add_column :order_items, :total_price_with_tax, :decimal, precision: 10, scale: 2
  end
end

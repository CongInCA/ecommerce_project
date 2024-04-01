class CreateOrderItemBackup < ActiveRecord::Migration[7.1]
  def change
    create_table :order_item_backups do |t|
      t.references :order, foreign_key: true
      t.integer :product_id
      t.integer :quantity
      t.decimal :price, precision: 10, scale: 2
      t.decimal :tax_rate, precision: 5, scale: 4
      t.timestamps
    end
  end
end

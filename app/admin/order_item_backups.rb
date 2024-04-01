ActiveAdmin.register OrderItemBackup do
    permit_params :order_id, :product_id, :quantity, :price, :tax_rate

    index do
        selectable_column
        id_column
        column :order_id
        column :product_id
        column :quantity
        column :price
        column :tax_rate
        actions
      end
    
      filter :user
      filter :total_price
    
  end
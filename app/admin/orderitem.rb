ActiveAdmin.register OrderItem do
    permit_params :order_id, :product_id, :quantity, :order_id, :price, :total_price_with_tax
  
    index do
      selectable_column
      id_column
      column :order
      column :product
      column :quantity
      column :order_id
      column :price
      column :total_price_with_tax
      actions
    end
  
    filter :order
    filter :product
    filter :quantity
  
    form do |f|
      f.inputs 'Order Item Details' do
        f.input :order
        f.input :product
        f.input :quantity
      end
      f.actions
    end
  end
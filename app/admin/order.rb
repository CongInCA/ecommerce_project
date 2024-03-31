ActiveAdmin.register Order do
    permit_params :user_id, :total_price, :total_price_with_tax

  
    index do
      selectable_column
      id_column
      column :user
      column :total_price
      column :total_price_with_tax
      actions
    end
  
    filter :user
    filter :total_price
  
    form do |f|
      f.inputs 'Order Details' do
        f.input :user
        f.input :total_price
      end
      f.actions
    end
  end
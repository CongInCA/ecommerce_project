ActiveAdmin.register Product do
    permit_params :name, :description, :price, :category_id
  
    filter :name
    filter :price
    filter :category_id

    form do |f|
      f.inputs do
        f.input :name
        f.input :description
        f.input :price
        f.input :category_id
        f.input :image, as: :file
      end
      f.actions
    end
  end
  
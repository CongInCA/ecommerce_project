ActiveAdmin.register Product do
    permit_params :name, :description, :price, :category_id, :image
  
    filter :name
    filter :price
    filter :category_id

    index do
        selectable_column
        id_column
        column :name
        column :description
        column :price
        column :category
        column "Image" do |product|
          if product.image.attached?
            image_tag(url_for(product.image), class: 'admin-index-image')
          else
            "No image available"
          end
        end
        actions
      end
    
      show do
        attributes_table do
          row :name
          row :description
          row :price
          row :category
          row :image do |product|
            if product.image.attached?
              image_tag rails_blob_path(product.image, only_path: true), class: 'product-image'
            else
              "No image attached"
            end
          end
        end
      end
    
    form do |f|
      f.inputs do
        f.input :name
        f.input :description
        f.input :price
        f.input :category
        f.input :image, as: :file
      end
      f.actions
    end
  end
  
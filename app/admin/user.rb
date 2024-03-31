ActiveAdmin.register User do
    permit_params :email, :password, :remember_created_at,:province_id, :address
  
    index do
      selectable_column
      id_column
      column :email
      column :encrypted_password
      column :province_id
      column :address
      column :created_at
      actions
    end
  
    filter :email
    filter :created_at
  end
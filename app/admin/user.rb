ActiveAdmin.register User do
    permit_params :email, :password, :remember_created_at
  
    index do
      selectable_column
      id_column
      column :email
      column :encrypted_password
      column :created_at
      actions
    end
  
    filter :email
    filter :created_at
  end
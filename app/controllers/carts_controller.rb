class CartsController < ApplicationController
  before_action :authenticate_user!, only: [:add_to_cart]

  def index
    @cart = session[:cart] || {}
  end

  def add_to_cart
    product_id = params[:product_id]
    session[:cart] ||= {}  
    session[:cart][product_id] ||= 0  
    session[:cart][product_id] += 1  
    flash[:notice] = "Product added to cart successfully."
  end

  def update_cart
    product_id = params[:product_id]
    quantity = params[:quantity].to_i
    session[:cart][product_id] = quantity
    flash[:notice] = "Shopping cart updated successfully."
    redirect_to carts_path
  end

  def remove_from_cart
    product_id = params[:product_id]
    session[:cart].delete(product_id)
    flash[:notice] = "Product removed from cart successfully."
    redirect_to carts_path
  end
end
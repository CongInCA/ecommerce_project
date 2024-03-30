class CartsController < ApplicationController
  before_action :authenticate_user!, only: [:add_to_cart]

  def index
    @cart = session[:cart] || {}
    @total_price = session[:total_price] || 0
  end

  def add_to_cart
    product_id = params[:product_id]
    session[:cart] ||= {}  
    session[:cart][product_id] ||= 0  
    session[:cart][product_id] += 1  

    update_total_price

    flash[:notice] = "Product added to cart successfully."
  end

  def update_cart
    product_id = params[:product_id]
    quantity = params[:quantity].to_i
  
    session[:cart][product_id] = quantity
  
    update_total_price
  
    flash[:notice] = "Shopping cart updated successfully."
    redirect_to carts_path
  end

  def remove_from_cart
    product_id = params[:product_id]
    session[:cart].delete(product_id)
    
    update_total_price
    
    flash[:notice] = "Product removed from cart successfully."
    redirect_to carts_path
  end

  private

  def update_total_price
    total_price = 0
    
    session[:cart].each do |product_id, quantity|
      product = Product.find(product_id)
      total_price += product.price * quantity
    end
    
    session[:total_price] = total_price
  end
end
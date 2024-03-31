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

  def checkout
    if session[:cart].blank?
      flash[:alert] = "Your shopping cart is empty."
      redirect_to carts_path
      return
    end
      
    @cart_items = prepare_cart_items
    @total_price = session[:total_price]
  
    render 'checkout'
  end

  def place_order
    if create_order
      session[:cart] = {}
      session[:total_price] = 0
      flash[:notice] = "Your order has been placed successfully."
      redirect_to root_path
    else
      flash[:alert] = "Failed to place your order. Please try again."
      redirect_to checkout_carts_path
    end
  end

  private

  def prepare_cart_items
    cart_items = []
    session[:cart].each do |product_id, quantity|
      product = Product.find(product_id)
      cart_items << { product: product, quantity: quantity, subtotal: product.price * quantity }
    end
    cart_items
  end

  def create_order
    tax_rate = calculate_tax_rate(current_user.province.name) 
    total_price = session[:total_price].to_f
    total_price_after_tax = calculate_total_price_after_tax(total_price, tax_rate).round(2)
    @order = Order.new(user_id: current_user.id, total_price: session[:total_price], total_price_with_tax: total_price_after_tax)
  
    if @order.save
      session[:cart].each do |product_id, quantity|
        product = Product.find(product_id)
        total_price_with_tax = calculate_total_price_with_tax(product.price, quantity, tax_rate).round(2)
        order_item = @order.order_items.build(product_id: product_id, quantity: quantity, price: product.price * quantity, total_price_with_tax: total_price_with_tax)
        order_item.save
      end
      return true
    else
      return false
    end
  end
  
  private
  
  def calculate_tax_rate(province_name)
    province = Province.find_by(name: province_name)
    return 0 if province.nil? 
    province.gst_rate + province.pst_rate + province.hst_rate
  end

  def calculate_total_price_after_tax(price, tax_rate)
    tax_amount = price * tax_rate
    total_price_after_tax = price + tax_amount
    return total_price_after_tax
  end

  def calculate_total_price_with_tax(price, quantity, tax_rate)
    subtotal = price * quantity
    tax_amount = subtotal * tax_rate
    total_price_with_tax = subtotal + tax_amount
    return total_price_with_tax
  end

  def update_total_price
    total_price = 0

    session[:cart].each do |product_id, quantity|
      product = Product.find(product_id)
      total_price += product.price * quantity
    end
    
    session[:total_price] = total_price
  end
end
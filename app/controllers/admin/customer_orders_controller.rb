module Admin
  class CustomerOrdersController < ApplicationController
    def index
      @customer_orders = Order.all.includes(:user)
    end
  end
end

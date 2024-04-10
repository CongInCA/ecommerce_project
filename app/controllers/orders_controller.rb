class OrdersController < ApplicationController
    before_action :authenticate_user! 

    def index
        @orders = Order.order(created_at: :desc)
    end
end

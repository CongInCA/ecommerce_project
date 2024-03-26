class ProductsController < ApplicationController
    def index
        if params[:filter] == "on_sale"
            @products = Product.where.not(discount_price: nil).page(params[:page]).per(20)
          elsif params[:filter] == "new"
            @products = Product.where("created_at >= ?", 3.days.ago).page(params[:page]).per(20)
          elsif params[:filter] == "recently_updated"
            @products = Product.where("created_at < updated_at AND updated_at >= ?", 3.days.ago).page(params[:page]).per(20)
          else
            @products = Product.all.page(params[:page]).per(20)
          end
    end
    
    def show
    @product = Product.find(params[:id])
    @category = Category.find(@product.category_id)
    end
end

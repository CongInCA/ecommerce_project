class ProductsController < ApplicationController
    def index
        @products = Product.all

        if params[:query].present? || params[:category_id].present?
          @products = @products.search(params[:query]) if params[:query].present?
          @products = @products.where(category_id: params[:category_id]) if params[:category_id].present?
        end
    
        if params[:filter] == "on_sale"
          @products = @products.where.not(discount_price: nil)
        elsif params[:filter] == "new"
          @products = @products.where("created_at >= ?", 3.days.ago)
        elsif params[:filter] == "recently_updated"
          @products = @products.where("created_at < updated_at AND updated_at >= ?", 3.days.ago)
        end
    
        @products = @products.page(params[:page]).per(20)
    end
    
    def show
    @product = Product.find(params[:id])
    @category = Category.find(@product.category_id)
    end
end

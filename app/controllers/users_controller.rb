class UsersController < ApplicationController
    before_action :authenticate_user!
  
    def update_address
      current_user.update(address_params)
      redirect_to checkout_carts_path
    end
  
    private
  
    def address_params
      params.require(:user).permit(:address, :province_id)
    end
  end
  
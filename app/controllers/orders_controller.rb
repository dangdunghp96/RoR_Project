class OrdersController < ApplicationController
  def index
  end

  def show
  end

  def checkout
    order = current_order
    if order.checkout
      session.delete :order_id
      flash[:success] = "Thanks for order!"
      redirect_to root_path
    end
  end

end

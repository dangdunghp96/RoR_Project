class OrdersController < ApplicationController
  def index
    user = current_user
    @pendings = user.orders.get_pending_orders
    @completes = user.orders.get_complete_orders
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

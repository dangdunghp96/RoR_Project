class Admin::OrdersController < Admin::AdminController
  def index
    @orders = Order.get_pending_orders.paginate(:page => params[:page], :per_page => 10)
  end

  def complete
    order = Order.find params[:id]
    order.complete
    flash[:success] = "Competed!"
    redirect_to admin_orders_path
  end
end

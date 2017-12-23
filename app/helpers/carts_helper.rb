module CartsHelper
  def current_order
      Order.find session[:order_id]
    rescue ActiveRecord::RecordNotFound
      session.delete :order_id
      Order.new(user_id: session[:user_id], order_status_id: "1")
  end

  def get_cart user
    @order = user.orders.find_by order_status_id: "1"
    if !@order.nil?
      session[:order_id] = @order.id
    end
  end
end

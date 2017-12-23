class CartsController < ApplicationController
  def show
    @order_items = current_order.order_items
  end

  def destroy
    @order = current_order
    @order.order_items.destroy_all
    @order_items = @order.order_items
    @order.save
  end
end

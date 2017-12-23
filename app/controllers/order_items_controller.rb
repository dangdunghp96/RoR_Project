class OrderItemsController < ApplicationController
  before_action :set_current_order, only: [:create, :update, :destroy]

  def create
    @order_item = @order.order_items.find_by product_id: order_item_params[:product_id]
    if @order_item
      @order_item.quantity += order_item_params[:quantity].to_i
      @order_item.save
      @order.save
    else
      @order_item = @order.order_items.build order_item_params
      @order.save
    end
    flash.now[:success] = "Added to your cart!"
    session[:order_id] = @order.id
  end

  def update
    @order_item = @order.order_items.find params[:id]
    @order_item.update_attributes order_item_params
    @order_items = @order.order_items
    @order.save
    flash.now[:success] = "Updated!"
  end

  def destroy
    @order_item = @order.order_items.find params[:id]
    @order_item.destroy
    @order_items = @order.order_items
    @order.save
    flash.now[:success] = "Deleted!"
  end

  private
  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end

  def set_current_order
    @order = current_order
  end
end

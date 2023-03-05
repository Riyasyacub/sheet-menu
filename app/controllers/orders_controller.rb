class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:show, :cancel]
  before_action :set_order, only: [:served, :show, :cancel, :processing]

  def index
    if params[:billed].present?
      @orders = current_user.carts.billed.today
    else
      @orders = current_user.carts.not_billed
    end
  end

  def show
  end

  def processing
    @item.process
    item_name = @item.menu_item.item_name
    flash.now[:success] = "#{item_name} is Processing"
    ActionCable.server.broadcast("cart_#{@item.cart_id}",type: 'success', message: "#{item_name} has started preparing")
  end

  def served
    @item.serve
    item_name = @item.menu_item.item_name
    flash.now[:success] = "#{item_name} is Served"
    ActionCable.server.broadcast("cart_#{@item.cart_id}",type: 'success', message: "#{item_name} is served")
  end

  def cancel
    @item.cancel
    item_name = @item.menu_item.item_name
    flash.now[:success] = "#{item_name} is Cancelled!"
    ActionCable.server.broadcast("cart_#{@item.cart_id}",type: 'alert', message: "#{item_name} got cancelled")
  end

  private

  def order_params
    params.permit(:id)
  end

  def set_order
    @item = Orderable.find_by(id: order_params[:id])
    return if @item.present?
    flash.now[:alert] = "Order not found!"
    render_turbo_flash_messages
  end
end

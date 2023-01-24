class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_order, only: [:served, :show]

  def index
    @pending_orders = current_user.carts.not_billed
    # @served_orders  = current_user.carts.billed.limit(20)
  end

  def show

  end

  def served
    @order.update(billed: true)
    flash.now[:success] = "Order Updated"
  end

  def cancel

  end

  private

  def serve_params
    params.permit(:id)
  end

  def cancel_params
    params.permit(:id)
  end

  def set_order
    @order = Cart.find_by(id: serve_params[:id])
    return if @order.present?
    flash.now[:alert] = "Order not found!"
    render turbo_stream: [turbo_stream.prepend("msg", partial: "layouts/flash")]
  end
end

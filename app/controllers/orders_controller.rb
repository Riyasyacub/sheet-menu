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
    flash.now[:success] = "Item Processing"
  end

  def served
    @item.serve
    flash.now[:success] = "Item Served"
  end

  def cancel
    @item.cancel
    flash.now[:success] = "Item Cancelled!"
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

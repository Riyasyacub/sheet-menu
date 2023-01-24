class CartController < ApplicationController
  before_action :check_cart, only: [:checkout]

  def show

  end

  def add
    item              = MenuItem.find_by(id: add_params[:id])
    qty               = add_params[:qty].to_i
    current_orderable = @cart.items.find_by(menu_item_id: item.id)
    if current_orderable && qty > 0
      current_orderable.update(qty: qty)
      flash.now[:success] = "Item quantity altered!"
    elsif qty <= 0
      current_orderable.destroy
      flash.now[:success] = "Item removed from cart!"
    else
      @cart.orderables.create(menu_item: item, qty: qty)
      flash.now[:success] = "Item added to cart!"
    end
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('cart', partial: 'menus/cart_item', locals: { items: @cart.items }),
                              turbo_stream.replace('cart-total', partial: 'cart/cart_total', locals: { items: @cart.items }),
                              turbo_stream.replace(item, partial: 'cart/add_form', locals: { item: item, qty: qty }),
                              turbo_stream.replace('cart-checkout', partial: 'cart/checkout_form'),
                              turbo_stream.replace('msg', partial: 'layouts/flash' )]
      end
    end
  end

  def remove
    orderable = Orderable.find_by(id: params[:id])
    item      = orderable.menu_item
    orderable.destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('cart', partial: 'menus/cart_item', locals: { items: @cart.items }),
                              turbo_stream.replace('cart-total', partial: 'cart/cart_total', locals: { items: @cart.items }),
                              turbo_stream.replace(item, partial: 'cart/add_form', locals: { item: item, qty: 0 })]
      end
    end
  end

  def checkout
    return if @cart_order.blank? || @cart_order.orderables.blank?
    session[:orders] = @cart_order.id
    # @cart.update(ordered: true, ordered_at: Time.now)
    @cart.checkout
    ActionCable.server.broadcast("orders_#{@cart_order.hotel_id}", html: render_order, message: "You have received an order")
    flash.now[:success] = "Your order has been made!"
  end

  private

  def checkout_params
    params.permit(:id, :table_id)
  end

  def add_params
    params.require('item').permit(:id, :qty)
  end

  def check_cart
    @cart_order = Cart.find_by(id: checkout_params[:id])
    return if @cart_order.present? && @cart_order.orderables.present?
    flash.now[:notice] = "Please add Items to cart to make an order!"
  end

  def set_table
    @table = Table.find_by(id: checkout_params[:table_id])
    return if @table.present?
    flash.now[:notice] = "Invalid table!"
  end

  def render_order
    ApplicationController.render(partial: 'orders/order', locals: { order: @cart, served: false })
  end
end

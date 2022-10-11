class CartController < ApplicationController

  before_action :create_cart

  def add
    item              = MenuItem.find_by(id: params[:id])
    qty               = params[:qty].to_i
    current_orderable = @cart.orderables.find_by(menu_item_id: item.id)
    if current_orderable && qty > 0
      current_orderable.update(qty: qty)
    elsif qty <= 0
      current_orderable.destroy
    else
      @cart.orderables.create(menu_item: item, qty: qty)
    end
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('cart', partial: 'menus/cart_item', locals: { cart: @cart }),
                              turbo_stream.replace('cart-total', "<turbo-frame id='cart-total'><p>₹ #{@cart.total}</p></turbo-frame>"),
                              turbo_stream.replace(item, partial: 'cart/add_form', locals: { item: item, qty: qty })]
      end
    end
  end

  def remove
    orderable = Orderable.find_by(id: params[:id])
    item = orderable.menu_item
    orderable.destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('cart', partial: 'menus/cart_item', locals: { cart: @cart }),
                              turbo_stream.replace('cart-total', "<turbo-frame id='cart-total'><p>₹ #{@cart.total}</p></turbo-frame>"),
                              turbo_stream.replace(item, partial: 'cart/add_form', locals: { item: item, qty: 0 })]
      end
    end
  end
end

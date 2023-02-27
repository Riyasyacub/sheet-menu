class ApplicationController < ActionController::Base
  before_action :find_cart

  def render_turbo_flash_messages
    render turbo_stream: [turbo_stream.prepend("msg", partial: "layouts/flash")]
  end

  private

  def find_cart
    @cart ||= Cart.find_by(id: session[:cart_id], billed: false)
    return if @cart.present?
    @table = Table.find_by(id: params[:id])
    @cart = Cart.new
    return if @table.blank?
    @cart = Cart.create(table: @table, hotel: @table.menu.user)
    session[:cart_id] = @cart.id
  end
end

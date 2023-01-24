class TablesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_table, only: [:show]

  def index
    @tables = current_user.menus.joins(:tables).select('menus.title as menu_name, tables.*').order('menus.title ,tables.name asc')
    @tables_with_qr = @tables.map do |table|
      {
        table: table,
        qr: RQRCode::QRCode.new(table_url(table))
      }
    end
  end

  def show
    @menu = @table.menu
    orderables = @cart.items.to_sql
    @menu = @menu.menu_items
                 .joins("left join (#{orderables}) orderables on orderables.menu_item_id = menu_items.id")
                 .select('menu_items.*, coalesce(orderables.qty,0) as qty')
                 .group_by(&:category)
  end

  private

  def set_table
    @table = Table.find_by(id: params[:id])
    return if @table.present?
    flash[:alert] = 'Table not found!'
    redirect_to root_path
  end
end

# frozen_string_literal: true

class MenusController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_menu, except: [:new, :create]

  def show
    orderables = @cart.orderables.to_sql
    @menu = @menu.menu_items
                 .joins("left join (#{orderables}) orderables on orderables.menu_item_id = menu_items.id")
                 .select('menu_items.*, coalesce(orderables.qty,0) as qty')
                 .group_by(&:category)
  end

  def new
    @menu = current_user.menus.new
  end

  def create
    @menu = current_user.menus.create_with_sheet_key(menu_params)
    if @menu.persisted?
      redirect_to authenticated_root_path
      flash[:success] = "Menu Created Successfully!"
    else
      redirect_to new_menu_path
      flash[:alert] = @menu.errors.full_messages
    end
  end

  def edit
  end

  def update
    if @menu.update(menu_params)
      redirect_to authenticated_root_path
      flash[:success] = "Menu Updated Successfully!"
    else
      redirect_to edit_menu_path
      flash[:alert] = @menu.errors.full_messages
    end
  end

  def qr_code
    # @qrcode = RQRCode::QRCode.new(menu_url(@menu))
    @codes = @menu.tables.map do |table|
      {
        table: table,
        qr: RQRCode::QRCode.new(table_url(table))
      }
    end
  end

  def sync
    Menu.sync!(@menu)
    redirect_to authenticated_root_path
    flash[:success] = "Synced Successfully!"
  end

  def destroy
    @menu.destroy
    redirect_to authenticated_root_path
    flash[:warning] = "Menu Deleted!"
  end

  private

  def menu_params
    params.require(:menu).permit(:sheet_key, :logo)
  end

  def set_menu
    @menu = Menu.find_by(id: params[:id])
    return if @menu.present?
    flash[:alert] = 'Menu not found!'
    redirect_to root_path
  end
end

# frozen_string_literal: true

class MenusController < ApplicationController
  before_action :authenticate_user!

  def show
    @menu = current_user.menus.find params[:id]
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = current_user.menus.create_with_sheet_key(menu_params['sheet_key'])
    if @menu.persisted?
      redirect_to authenticated_root_path
      flash[:success] = "Menu Created Successfully!"
    else
      redirect_to new_menu_path
    end
  end

  def edit

  end

  def update

  end

  def qr_code
    @menu = current_user.menus.find params[:id]
    @qrcode = RQRCode::QRCode.new(menu_url(@menu))
  end

  def sync
    menu = current_user.menus.find params[:id]
    menu.sync!
    redirect_to authenticated_root_path
    flash[:success] = "Synced Successfully!"
  end

  def destroy
    @menu = Menu.find params[:id]
    @menu.destroy
    redirect_to authenticated_root_path
    flash[:warning] = "Menu Deleted!"
  end

  private

  def menu_params
    params.require(:menu).permit(:sheet_key)
  end
end

# frozen_string_literal: true

class MenusController < ApplicationController
  before_action :authenticate_user!

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.create_with_sheet_key(current_user, menu_params)
    if @menu.persisted?
      redirect_to authenticated_root_path
    else
      redirect_to new_menu_path
    end

  end

  private

  def menu_params
    params.require(:menu).permit(:sheet_key)
  end
end

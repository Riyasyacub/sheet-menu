# frozen_string_literal: true

class MenusController < ApplicationController
  before_action :authenticate_user!

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.create(menu_params)
    if @menu.errors.any?
      render :new
    else
      redirect_to authenticated_root_path
    end

  end

  private

  def menu_params
    params.require(:menu).permit(:title,:sheet_key)
  end
end

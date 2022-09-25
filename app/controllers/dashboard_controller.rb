class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @menu = current_user.menus
  end
end

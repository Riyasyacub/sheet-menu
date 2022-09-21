# frozen_string_literal: true

class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def update
    current_user.update(setting_params)
    bypass_sign_in(current_user)
    redirect_to authenticated_root_path
  end

  private

  def setting_params
    params.require(:setting).permit(:email,:password)
  end
end

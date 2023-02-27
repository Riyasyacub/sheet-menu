module ApplicationHelper

  def unknown_user?
    return false if user_signed_in?
    return false if devise_controller? || params[:controller].in?(['home'])
    true
  end

  def render_turbo_flash_messages
    turbo_stream.prepend("msg", partial: "layouts/flash")
  end

end

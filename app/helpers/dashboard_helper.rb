module DashboardHelper

  def dashboard_links
    [{
       name:   'dashboard',
       path:   authenticated_root_path,
       active: controller_name == 'dashboard'
     },
     {
       name:   'Pending Orders',
       path:   orders_path,
       active: controller_name == 'orders' && params[:billed].blank?
     },
     {
       name:   'Billed Orders',
       path:   orders_path(billed: true),
       active: controller_name == 'orders' && params[:billed].present?
     },
     {
       name:   'Settings',
       path:   settings_path,
       active: controller_name == 'settings'
     }]
  end

  def dashboard_header_class(controller)
    active   = "border-green-500 text-gray-900 inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium"
    inactive = "border-transparent text-gray-500 hover:border-gray-300 hover:text-gray-700 inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium"

    controller_name == controller ? active : inactive
  end

  def dashboard_mobile_header_class(controller)
    active   = "bg-green-50 border-green-500 text-green-700 block pl-3 pr-4 py-2 border-l-4 text-base font-medium"
    inactive = "border-transparent text-gray-500 hover:bg-gray-50 hover:border-gray-300 hover:text-gray-700 block pl-3 pr-4 py-2 border-l-4 text-base font-medium"

    controller_name == controller ? active : inactive
  end
end

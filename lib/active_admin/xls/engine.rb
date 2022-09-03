module ActiveAdmin
  module Xls
    # Extends ActiveAdmin with xls downloads
    class Engine < ::Rails::Engine
      engine_name 'active_admin_xls'

      initializer 'active_admin.xls', group: :all do
        if Mime::Type.lookup_by_extension(:xls).nil?
          Mime::Type.register 'application/vnd.ms-excel', :xls
        end

        ActiveAdmin::Views::PaginatedCollection.add_format :xls

        ActiveAdmin::ResourceDSL.send :include, ActiveAdmin::Xls::DSL
        ActiveAdmin::Resource.send :include, ActiveAdmin::Xls::ResourceExtension
      end
      
      ActiveSupport.on_load(:active_admin_controller) do
        # Source | https://github.com/activeadmin/activeadmin/issues/7196#issuecomment-1132578565
        ActiveAdmin::ResourceController.send(
          :prepend,
          ActiveAdmin::Xls::ResourceControllerExtension
        )        
      end      
    end
  end
end

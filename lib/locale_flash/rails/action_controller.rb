module LocaleFlash
  module Rails
    module ActionController
      
    private
    
      def locale_flash(key)
        flash[key] = {:controller => controller_path, :action => action_name}
      end

      def locale_notice
        locale_flash :notice
      end

      def locale_alert
        locale_flash :alert
      end
    end
  end
end
  
module ActionController
  class Base
    include LocaleFlash::Rails::ActionController
  end
end
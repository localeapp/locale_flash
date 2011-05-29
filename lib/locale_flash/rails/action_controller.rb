module LocaleFlash
  module Rails
    module ActionController
      
    private
    
      def locale_flash(type, options={})
        flash[type] = LocaleFlash::Flash.new(
          :controller => controller_path,
          :action     => action_name,
          :type       => type,
          :options    => options
        ).to_params
      end

      def locale_notice(options={})
        locale_flash :notice, options
      end

      def locale_alert(options={})
        locale_flash :alert, options
      end
    end
  end
end
  
module ActionController
  class Base
    include LocaleFlash::Rails::ActionController
  end
end
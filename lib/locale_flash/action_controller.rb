module LocaleFlash
  module ActionController
    def locale_flash(key)
      flash[key] = {:controller => controller_name, :action => action_name}
    end

    def locale_notice
      locale_flash :notice
    end

    def locale_alert
      locale_flash :alert
    end
  end
end
  
module ActionController
  class Base
    include LocaleFlash::ActionController
  end
end
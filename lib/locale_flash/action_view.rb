module LocaleFlash
  module ActionView

    def locale_flash
      output = ''
      flash.each do |key, value|
        if value.is_a?(Hash)
          output << wrap_flash(key, t(['controllers', value[:controller], value[:action], key].join('.')))
        else
          output << wrap_flash(key, value)
        end
      end
      output
    end

    def wrap_flash(key, value)
      content_tag(:div, value, :class => key)
    end

  end
end


module ActionView
  class Base
    include LocaleFlash::ActionView
  end
end
module LocaleFlash
  module ActionView

    def locale_flash
      output = ''
      flash.each do |key, value|
        if value.is_a?(Hash)
          output << wrap_flash(key, t(flash_path(key, value), :default => flash_default(key, value)))
        else
          output << wrap_flash(key, value)
        end
      end
      output
    end

    def wrap_flash(key, value)
      %Q{<div class="#{key}">#{value}</div>}
    end

    def flash_path(key, value)
      ['controllers', value[:controller], value[:action], 'flash', key].join('.').to_sym
    end

    def flash_default(key, value)
      [ ['controllers', value[:controller], 'flash', key],
        ['controllers', 'flash', value[:action], key],
        ['controllers', 'flash', key]
      ].map { |i| i.join('.').to_sym }
    end

  end
end


module ActionView
  class Base
    include LocaleFlash::ActionView
  end
end
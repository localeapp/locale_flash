module LocaleFlash
  module ActionView

    def locale_flash
      output = ''
      flash.each do |key, value|
        if value.is_a?(Hash) && value[:controller] && value[:action]
          output << locale_flash_wrap(key, t(locale_flash_key(key, value), :default => locale_flash_default(key, value)))
        else
          output << locale_flash_wrap(key, value)
        end
      end

      output.respond_to?(:html_safe) ? output.html_safe : output
    end

  private

    def locale_flash_wrap(key, value)
      %Q{<div class="#{key}">#{value}</div>}
    end

    def locale_flash_key(key, value)
      ['controllers', value[:controller].split('/').join('.'), value[:action], 'flash', key].join('.').to_sym
    end

    def locale_flash_default(type, msg)
      controllers = msg[:controller].split('/')

      if controllers.size > 1
        defaults = []
        controllers.each_with_index do |controller, i|
          controller = controllers[0, (controllers.size - i)].join('.')
          parent     = controllers[0, (controllers.size - i - 1)].join('.')
          defaults << ['controllers', controller, 'flash', type]
          defaults << ['controllers', parent, 'flash', msg[:action], type] unless parent.empty?
        end
      else
        defaults = [['controllers', controllers.first, 'flash', type]]
      end

      defaults << ['controllers', 'flash', msg[:action], type]
      defaults << ['controllers', 'flash', type]
      defaults.map { |i| i.join('.').to_sym }
    end

  end
end


module ActionView
  class Base
    include LocaleFlash::ActionView
  end
end
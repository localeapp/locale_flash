module LocaleFlash
  module Rails
    module ActionView

      def locale_flash
        output = ''
        flash.each do |type, args|
          output << LocaleFlash::Flash.from_params(type, args).to_html
        end
        output.respond_to?(:html_safe) ? output.html_safe : output
      end

    end
  end
end


module ActionView
  class Base
    include LocaleFlash::Rails::ActionView
  end
end
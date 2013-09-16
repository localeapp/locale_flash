module LocaleFlash
  class Flash
    attr_reader :type, :controller, :action, :options, :message

    def initialize(args={})
      @type       = args[:type]
      @controller = args[:controller]
      @action     = args[:action]
      @options    = args[:options] || {}
      @message    = args[:message]
    end

    def self.from_params(type, params={})
      if params.is_a?(Hash) && params[:controller] && params[:action]
        new(params.merge(:type => type))
      else
        new(:type => type, :message => params.to_s)
      end
    end

    def to_params
      { :controller => controller,
        :action     => action,
        :options    => options }
    end

    def legacy?
      !message.nil?
    end

    def controllers
      controller.split('/')
    end

    def key
      ['controllers', controllers.join('.'), action, 'flash', type].join('.').to_sym
    end

    def fallbacks
      if controllers.size > 1
        defaults = []
        controllers.each_with_index do |current, i|
          current    = controllers[0, (controllers.size - i)].join('.')
          parent     = controllers[0, (controllers.size - i - 1)].join('.')
          defaults << ['controllers', current, 'flash', type]
          defaults << ['controllers', parent, 'flash', action, type] unless parent.empty?
        end
      else
        defaults = [['controllers', controller, 'flash', type]]
      end

      defaults << ['controllers', 'flash', action, type]
      defaults << ['controllers', 'flash', type]
      defaults.map { |i| i.join('.').to_sym }
    end

    def to_html
      str = if legacy?
        message
      else
        I18n.t(key, options.merge(:default => fallbacks))
      end
      LocaleFlash::Config.template.call(type, str)
    end
  end
end

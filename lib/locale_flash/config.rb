module LocaleFlash
  class Config
    DEFAULT_TEMPLATE = -> (type, str) { %Q{<div class="#{type}">#{str}</div>} }

    def self.template=(value)
      value = value.to_proc
      @@template = value
    end

    def self.template
      defined?(@@template) ? @@template : DEFAULT_TEMPLATE
    end
  end
end

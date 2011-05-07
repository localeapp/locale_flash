module ActionView
  class Base
    attr_accessor :flash

    def t(key, args={})
      I18n.t(key, args)
    end
  end
end
  
class UsersTemplate < ActionView::Base
end
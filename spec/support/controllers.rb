module ActionController
  class Base
    attr_accessor :flash

    def initialize
      @flash = {}
    end
  end
end

class UsersController < ActionController::Base

  def edit
    locale_flash(:warning)
  end

  def create
    locale_notice
  end

  def destroy
    locale_alert
  end

private

  def controller_name
    'users'
  end

  def action_name
    'create'
  end
end
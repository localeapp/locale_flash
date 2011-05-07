class UsersController < ActionController::Base
  attr_accessor :flash

  def initialize
    @flash = {}
  end

  def controller_name
    'users'
  end

  def action_name
    'create'
  end
end
require 'spec_helper'
require 'support/controllers'

describe ActionController::Base do
  before(:each) do
    @controller = UsersController.new
  end

  describe '#locale_flash(key)' do
    it "sets flash[key] to a hash containing the controller name and the action name" do
      @controller.locale_flash(:foo)
      @controller.flash.should == {:foo => {:controller => 'users', :action => 'create'}}
    end
  end

  describe '#locale_notice' do
    it "sets flash[:notice] to a hash contianing the controller name and the action name" do
      @controller.locale_notice
      @controller.flash.should == {:notice => {:controller => 'users', :action => 'create'}}
    end
  end

  describe '#locale_alert' do
    it "sets flash[:alert] to a hash contianing the controller name and the action name" do
      @controller.locale_alert
      @controller.flash.should == {:alert => {:controller => 'users', :action => 'create'}}
    end
  end
end
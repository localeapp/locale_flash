require 'spec_helper'
require 'support/controllers'

describe ActionController::Base do
  before(:each) do
    @controller = UsersController.new
  end

  describe '#locale_flash(key)' do
    it "sets flash[key] to a hash containing the controller name and the action name" do
      @controller.edit
      @controller.flash.should == {:warning => {:controller => 'users', :action => 'create'}}
    end
  end

  describe '#locale_notice' do
    it "sets flash[:notice] to a hash contianing the controller name and the action name" do
      @controller.create
      @controller.flash.should == {:notice => {:controller => 'users', :action => 'create'}}
    end
  end

  describe '#locale_alert' do
    it "sets flash[:alert] to a hash contianing the controller name and the action name" do
      @controller.destroy
      @controller.flash.should == {:alert => {:controller => 'users', :action => 'create'}}
    end
  end
end
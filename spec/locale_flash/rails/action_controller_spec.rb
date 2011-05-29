require 'spec_helper'
require 'support/controllers'

describe ActionController::Base do
  before(:each) do
    @controller = UsersController.new
  end

  describe '#locale_flash(key, options)' do
    it "sets flash[key] to a hash containing the controller name, the action name and passed options" do
      @controller.edit
      @controller.flash.should == {:warning => {:controller => 'users', :action => 'create', :options => {:name => 'Chris'}}}
    end

    context "when the controller is nested" do
      before(:each) do
        @controller = Admin::UsersController.new
      end

      it "sets the flash[key] to a hash containing the full path to the controller and the action name" do
        @controller.show
        @controller.flash.should == {:alert => {:controller => 'admin/users', :action => 'show', :options => {}}}
      end
    end
  end

  describe '#locale_notice(options)' do
    it "sets flash[:notice] to a hash contianing the controller name, the action name and passed options" do
      @controller.create
      @controller.flash.should == {:notice => {:controller => 'users', :action => 'create', :options => {:name => 'John'}}}
    end
  end

  describe '#locale_alert(options)' do
    it "sets flash[:alert] to a hash contianing the controller name, the action name and passed options" do
      @controller.destroy
      @controller.flash.should == {:alert => {:controller => 'users', :action => 'create', :options => {:name => 'Martin'}}}
    end
  end
end
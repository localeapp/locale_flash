require 'spec_helper'

describe LocaleFlash::Flash do
  describe '.from_params(type, params)' do
    context "when a complete Hash is passed" do
      before do
        @flash = LocaleFlash::Flash.from_params(:notice, {
          :controller => 'admin/users',
          :action     => 'update',
          :options    => {:name => 'Chris'}
        })
      end

      it "returns a non legacy Flash" do
        @flash.should_not be_legacy
      end

      it "sets the type" do
        @flash.type.should == :notice
      end

      it "sets the action" do
        @flash.action.should == 'update'
      end

      it "sets the controller" do
        @flash.controller.should == 'admin/users'
      end

      it "sets the options" do
        @flash.options.should == {:name => 'Chris'}
      end
    end

    context "when an invalid Hash is passed" do
      before do
        @flash = LocaleFlash::Flash.from_params(:notice, {
          :controller => 'admin/users',
          :options    => {:name => 'Chris'}
          # NOTE no :action
        })
      end

      it "returns a legacy Flash" do
        @flash.should be_legacy
      end

      it "sets the type" do
        @flash.type.should == :notice
      end

      it "sets the message to the string version of the hash" do
        @flash.message.should_not be_nil
        @flash.message.should be_kind_of(String)
      end
    end

    context "when a String is passed" do
      before do
        @flash = LocaleFlash::Flash.from_params(:notice, "I'm a flash")
      end

      it "returns a legacy Flash" do
        @flash.should be_legacy
      end

      it "sets the type" do
        @flash.type.should == :notice
      end

      it "sets message to the String" do
        @flash.message.should == "I'm a flash"
      end
    end

    context "when a hash with string keys is passed" do
      subject :flash do
        LocaleFlash::Flash.from_params(:notice, {
          "controller"  => "admin/users",
          "action"      => "update",
          "options"     => {
            :foo  => "bar",
            "baz" => "qux"
          }
        })
      end

      it "builds the flash" do
        expect(flash).to be
      end

      it "sets the controller" do
        expect(flash.controller).to eq "admin/users"
      end

      it "sets the action" do
        expect(flash.action).to eq "update"
      end

      it "sets the options" do
        expect(flash.options).to include foo: "bar"
      end

      it "converts options with a string key to one with a symbol key" do
        expect(flash.options).to include baz: "qux"
      end
    end
  end

  describe '#to_params' do
    it "returns a hash of attributes" do
      LocaleFlash::Flash.new(
        :type       => :notice,
        :controller => 'admin/users',
        :action     => 'show',
        :options    => {:foo => :bar}
      ).to_params.should == {
        :controller => 'admin/users',
        :action     => 'show',
        :options    => {:foo => :bar}
      }
    end
  end

  describe '#legacy?' do
    it "returns true when message is set" do
      LocaleFlash::Flash.new(:message => 'foo').should be_legacy
    end

    it "returns false when message is NOT set" do
      LocaleFlash::Flash.new.should_not be_legacy
    end
  end

  describe '#controllers' do
    it "returns an array with 1 element when controller is simple" do
      LocaleFlash::Flash.new(:controller => 'users').controllers.should == ['users']
    end

    it "returns an array of controllers when controller is nested" do
      LocaleFlash::Flash.new(:controller => 'admin/users').controllers.should == ['admin', 'users']
    end
  end

  describe '#key' do
    it "returns the correct key for a simple controller" do
      LocaleFlash::Flash.new(
        :controller => 'users',
        :action     => 'update',
        :type       => :notice
      ).key.should == :'controllers.users.update.flash.notice'
    end

    it "returns the correct key for a newsted controller" do
      LocaleFlash::Flash.new(
        :controller => 'admin/users',
        :action     => 'update',
        :type       => :notice
      ).key.should == :'controllers.admin.users.update.flash.notice'
    end
  end

  describe '#fallbacks' do
    it "should be correct for simple controllers" do
      LocaleFlash::Flash.new(
        :controller => 'users',
        :action => 'show',
        :type => :notice
      ).fallbacks.should == [
        :"controllers.users.flash.notice",
        :"controllers.flash.show.notice",
        :"controllers.flash.notice"
      ]
    end

    it "should be correct for nested controllers" do
      LocaleFlash::Flash.new(
        :controller => 'admin/users',
        :action => 'show',
        :type => :notice
      ).fallbacks.should == [
        :"controllers.admin.users.flash.notice",
        :"controllers.admin.flash.show.notice",
        :"controllers.admin.flash.notice",
        :"controllers.flash.show.notice",
        :"controllers.flash.notice"
      ]
    end

    it "should be correct for multiply nested controllers" do
      LocaleFlash::Flash.new(
        :controller => 'admin/users/projects',
        :action => 'show',
        :type => :notice
      ).fallbacks.should == [
        :"controllers.admin.users.projects.flash.notice",
        :"controllers.admin.users.flash.show.notice",
        :"controllers.admin.users.flash.notice",
        :"controllers.admin.flash.show.notice",
        :"controllers.admin.flash.notice",
        :"controllers.flash.show.notice",
        :"controllers.flash.notice"
      ]
    end
  end

  describe '#to_html' do
    def wrap(str)
      %Q{<div class="notice">#{str}</div>}
    end

    context "when flash is legacy" do
      it "returns the message" do
        flash = LocaleFlash::Flash.new(:message => 'Hello there!', :type => :notice)
        flash.to_html.should == wrap('Hello there!')
      end
    end

    context "when flash is a locale_flash" do
      it "returns the translated string" do
        flash = LocaleFlash::Flash.new(:controller => 'users', :action => 'create', :type => :notice)
        flash.to_html.should == wrap('Found in controllers.users.create.flash.notice')
      end

      it "passes options to I18n" do
        flash = LocaleFlash::Flash.new(:controller => 'users', :action => 'show', :type => :notice, :options => {:name => 'Chris'})
        flash.to_html.should == wrap('Showing profile for Chris')
      end
      
      it "passes fallbacks to I18n" do
        flash = LocaleFlash::Flash.new(:controller => 'users', :action => 'destroy', :type => :notice)
        flash.to_html.should == wrap('Found in controllers.users.flash.notice')
      end
    end
  end
end
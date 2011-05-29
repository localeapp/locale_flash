# locale_flash

## Installation

Add locale_flash to your Gemfile :

    gem 'locale_flash'

Install the gem :

    bundle install

And off you go!

## Use

### In your controllers

Instead of manually assigning a value to flash[:notice] or flash[:alert], just call the *locale_flash* method like so :

    class UsersController < ActionController::Base
      def create
        @user = User.new(params[:user])
        if @user.save
          locale_flash(:notice)
          # redirect or render...
        else
          locale_flash(:alert)
          # redirect or render...
        end
      end
    end

Notice and Alert are such common keys to assign to a flash message that 2 convenience methods are also included : *locale_notice* and *locale_alert*. This means that the previous example can be written like so :

    class UsersController < ActionController::Base
      def create
        @user = User.new(params[:user])
        if @user.save
          locale_notice
          # redirect or render...
        else
          locale_alert
          # redirect or render...
        end
      end
    end

### In your views

Simply call locale_flash from your views like so :

    <div id="flash">
      <%= locale_flash %>
    </div>

This will produce HTML output like this :

    <div id="flash">
      <div class="notice">My message here</div>
    </div>


Note : if you are adding locale_flash to an existing application with manual assignments to flash[:notice], this will be rendered without I18n lookups.

### I18n fallback order

Your actual message text should be stored in your locale files (ie: in config/locales/*.yml).

locale_file will first look for the most specific message that matches the controller and action from which the flash was created from, and if that's missing, will fallback to more generic messages.

Given that I call *locale_notice* from the create action in a UsersController, the order of fallbacks will be as follows :

    controllers.users.create.flash.notice # this is the most specific message
    controllers.users.flash.notice        # fallback to the notice message for this controller
    controllers.flash.create.notice       # fallback to the notice message for all create actions
    controllers.flash.notice              # fallback to the generic notice message

Given a nested Admin::UsersController, the order of fallbacks will be as follows :

    controllers.admin.users.create.flash.notice
    controllers.admin.create.flash.show.notice
    controllers.admin.create.flash.notice
    controllers.admin.flash.notice
    controllers.flash.create.notice
    controllers.flash.notice

## TODO
+ Add an option to configure the wrapping html tags/classes
+ Add the option of predefining common messages (like resource_created for example)
class ApplicationController < ActionController::Base
  before_action :set_current_user
  include SessionsHelper
  include PostsHelper

  def hello
    render html: 'hello'
  end

  private

   def logged_in_user
     unless logged_in?
       store_location
       flash[:danger] = "Please log in."
       redirect_to login_url
     end
   end

   def set_current_user
     @user = current_user
   end
end

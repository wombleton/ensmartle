# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Twitter::AuthenticationHelpers
  
  helper :all # include all helpers, all the time
  filter_parameter_logging :password, :password_confirmation
  
  helper_method :current_user
  
  Time.zone = "Auckland"

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'aaa1d8b8e9dcf98811bcd2fca9b3a827'
  
  rescue_from Twitter::Unauthorized, :with => :force_sign_in

  private
  def force_sign_in(exception)
    reset_session
    flash[:error] = 'Seems your credentials are not good anymore. Please sign in again.'
    redirect_to new_session_path
  end
end

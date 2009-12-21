class SessionsController < ApplicationController
  layout "mention"
  def new
    redirect_to user_path(current_user) if current_user
  end
  
  def create
    oauth.set_callback_url(finalize_session_url)
    
    session['rtoken']  = oauth.request_token.token
    session['rsecret'] = oauth.request_token.secret

    redirect_to oauth.request_token.authorize_url
  end
  
  def destroy
    reset_session
    redirect_to login_path
  end
  
  def finalize
    oauth.authorize_from_request(session['rtoken'], session['rsecret'], params[:oauth_verifier])
    
    session['rtoken']  = nil
    session['rsecret'] = nil
    
    profile = Twitter::Base.new(oauth).verify_credentials
    user    = User.find_or_create_by_screen_name(profile.screen_name)
    
    user.update_attributes({
      :atoken => oauth.access_token.token, 
      :asecret => oauth.access_token.secret,
      :profile_image_url => profile.profile_image_url,
      :url => profile.url,
      :name => profile.name
    })
    
    sign_in(user)
    redirect_back_or root_path
  end
  
  private
    def oauth
      @oauth ||= Twitter::OAuth.new(ConsumerConfig['token'], ConsumerConfig['secret'], :sign_in => true)
    end
end

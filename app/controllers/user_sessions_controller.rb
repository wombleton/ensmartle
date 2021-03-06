class UserSessionsController < ApplicationController
  layout "mice"
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save do |result|
        if result
          flash[:notice] = "Successfully logged in."
          redirect_to missions_url
        else
          redirect_to missions_url
        end
      end
    end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "Successfully logged out."
    redirect_to missions_url
  end
end

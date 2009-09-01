class UsersController < ApplicationController
  layout "mice"
  def create
    @user = User.new(params[:user])
    if @user.save do |result|
        if result
          flash[:notice] = "Registration successful."
          redirect_to missions_url
        else
          render :action => 'new'
        end
      end
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.attributes = params[:user]
    if @user.save
      flash[:notice] = "Successfully updated profile."
      redirect_to missions_url
    else
      render :action => 'edit'
    end
  end

  def new
    @user = User.new
  end
end

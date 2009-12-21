class UsersController < ApplicationController
  before_filter :authenticate

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

  def index
    
  end

  def new
    @user = User.new
  end

  def use_sheet
    @sheet = Sheet.find(params[:sheet])
    session[:sheet] = @sheet.id unless @sheet.nil?
    render :text => "Now using #{@sheet.name} as your character!"
  end
end

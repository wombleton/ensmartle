class UsersController < ApplicationController
  before_filter :authenticate, :only => :edit

  layout "mention"

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.attributes = params[:user]
    if @user.save
      flash[:notice] = "Successfully updated profile."
    else
      flash[:notice] = "Failed to update stance."
    end
    redirect_to mention_index_path
  end

  def show
    @user = User.find_by_screen_name(params[:id])
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

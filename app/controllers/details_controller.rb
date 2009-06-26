class DetailsController < ApplicationController
  # POST /details
  # POST /details.xml
  def create
    @detail = Detail.new(params[:detail])
    @detail.page = Page.find(params[:page_id])
    @detail.remote_ip = request.remote_ip
    session[:user_name] = @detail.user_name

    if @detail.comment.empty?
      flash[:error] = "Comment can't be empty"
      redirect_to @detail.page
    else
      respond_to do |format|
        if @detail.save
          flash[:notice] = 'Comment added!'
          format.html { redirect_to(@detail.page) }
          format.xml  { render :xml => @detail, :status => :created, :location => @detail }
        else
          format.html { redirect_to(@detail.page) }
          format.xml  { render :xml => @detail.errors, :status => :unprocessable_entity }
        end
      end
    end
  end
end

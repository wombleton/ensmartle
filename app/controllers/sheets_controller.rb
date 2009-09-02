class SheetsController < ApplicationController
  layout "mice"
  # GET /sheets
  # GET /sheets.xml
  def index
    options = {:order => "name"}
    options[:conditions] = { :user_id => current_user.id } if current_user
    @sheets = Sheet.find(:all, options)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sheets }
    end
  end

  # GET /sheets/1
  # GET /sheets/1.xml
  def show
    @sheet = Sheet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sheet }
    end
  end

  # GET /sheets/new
  # GET /sheets/new.xml
  def new
    @sheet = Sheet.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sheet }
    end
  end

  # GET /sheets/1/edit
  def edit
    @sheet = Sheet.find(params[:id])
  end

  # POST /sheets
  # POST /sheets.xml
  def create
    @sheet = Sheet.new(params[:sheet])
    @sheet.user = current_user

    respond_to do |format|
      if @sheet.save
        flash[:notice] = 'Sheet was successfully created.'
        format.html { redirect_to(@sheet) }
        format.xml  { render :xml => @sheet, :status => :created, :location => @sheet }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sheet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sheets/1
  # PUT /sheets/1.xml
  def update
    @sheet = Sheet.find(params[:id])

    respond_to do |format|
      if @sheet.update_attributes(params[:sheet])
        flash[:notice] = 'Sheet was successfully updated.'
        format.html { redirect_to(@sheet) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sheet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sheets/1
  # DELETE /sheets/1.xml
  def destroy
    @sheet = Sheet.find(params[:id])
    @sheet.destroy

    respond_to do |format|
      format.html { redirect_to(sheets_url) }
      format.xml  { head :ok }
    end
  end
end

class MissionsController < ApplicationController
  layout "mice"

  # GET /missions
  # GET /missions.xml
  def index
    @missions = Mission.count(:all)
    @rolls = Roll.count(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @missions }
    end
  end

  # GET /missions/1
  # GET /missions/1.xml
  def show
    @mission = Mission.find_or_create_by_permalink(params[:id], :include => :events)
    @event = Event.new
    @sheets = Sheet.find_all_by_user_id(current_user, :order => "name")
    @sheet = Sheet.find(session[:sheet]) if session[:sheet]
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mission }
    end
  end

  # GET /missions/new
  # GET /missions/new.xml
  def new
    @mission = Mission.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mission }
    end
  end

  # GET /missions/1/edit
  def edit
    @mission = Mission.find(params[:id])
  end

  # POST /missions
  # POST /missions.xml
  def create
    @mission = Mission.new(params[:mission])

    respond_to do |format|
      if @mission.save
        flash[:notice] = 'Mission was successfully created.'
        format.html { redirect_to(@mission) }
        format.xml  { render :xml => @mission, :status => :created, :location => @mission }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /missions/1
  # PUT /missions/1.xml
  def update
    @mission = Mission.find_by_permalink(params[:id])

    roll and return if params[:roll] # don't edit but make a new roll
    explode and return if params[:explode] # don't edit but explode an existing roll
    
    respond_to do |format|
      if @mission.update_attributes(params[:mission])
        flash[:notice] = 'Mission was successfully updated.'
        format.html { redirect_to(@mission) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /missions/1
  # DELETE /missions/1.xml
  def destroy
    @mission = Mission.find(params[:id])
    @mission.destroy

    respond_to do |format|
      format.html { redirect_to(missions_url) }
      format.xml  { head :ok }
    end
  end

  def roll
    session[:by] = params[:by]
    roll = Roll.create(:mission => @mission, :by => params[:by], :exploded => false, :dice => params[:roll], :ip_address => request.remote_ip)
    @mission.rolls << roll
    latest = Time.parse(params[:latest]).utc unless params[:latest].empty?
    render :partial => "roll", :collection => @mission.rolls.find(:all, :conditions => ["updated_at > ?", latest || 1.week.ago])
  end

  def explode
    roll = Roll.find(params[:explode])
    roll.explode!
    render :partial => "roll", :locals => { :roll => roll } 
  end

  def check_user
    unless sessions[:user].nil?
      
    end
  end
end

class EventsController < ApplicationController
  def index
    @mission = Mission.find_by_permalink(params[:mission_id], :include => :events)
    respond_to do |format|
      format.json render :json => @events
    end
  end
  
  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])
    @event.user = current_user
    @event.mission = Mission.find_or_create_by_permalink(params[:mission_id])
    @event.sheet = Sheet.find(session[:sheet]) if session[:sheet]

    respond_to do |format|
      if @event.save
        format.html { render :text => "ok" }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end
end

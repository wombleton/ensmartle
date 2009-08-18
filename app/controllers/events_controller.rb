class EventsController < ApplicationController
  # POST /events
  # POST /events.xml
  def create
    session[:by] = params[:event][:by]
    @event = Event.new(params[:event])
    @mission = Mission.find_by_permalink(params[:mission_id])
    @event.mission = @mission

    respond_to do |format|
      if @event.save
        flash[:notice] = 'Event was successfully created.'
        format.html { render :text => "ok" }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end
end

class EventsController < ApplicationController
  URL = "http://api.notify.io/v1/notify/e9d872d8ac47207d95aabd985a988335?api_key=11efvfi916ywdeagcti"
  def index
    @mission = Mission.find_by_permalink(params[:mission_id], :include => :events)
    respond_to do |format|
      since = Time.at(params[:since] || 0)
      events = @mission.events.find(:all, :conditions => ["updated_at > ?", since])
      results = events.map{|event| {
          :id => event.id,
          :user => event.user.screen_name,
          :result => event.result,
          :sheet => event.sheet.try(:name),
          :updated_at => event.updated_at.to_i
      }}
      format.json { render :json => results }
    end
  end
  
  # POST /events
  # POST /events.xml
  def create
    @user = current_user
    params[:event].update(:user_id => @user.id, :sheet_id => @user.latest_sheet.try(:id))
    @event = Event.new(params[:event])
    @event.parse(params[:mission_id])

    respond_to do |format|
      if @event.save
        Net::HTTP.post_form(URI.parse(URL), { :text => @event.result })

        format.html { render :text => "ok" } if request.xhr?
        format.html { redirect_to @event.mission } unless request.xhr?
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end
end

class CometController < ApplicationController
  def index
    @expire_at = 30.seconds.from_now
    while Time.new < @expire_at
      @events = Event.find(:all, :include => :mission, :conditions => ["missions.permalink = ? AND events.created_at > ?", params[:mission], Time.at(params[:latest] || 0)])
      break unless @events.empty?
      sleep(1)
    end
    render :json => @events
  end
end

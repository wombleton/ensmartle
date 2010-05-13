class Event < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  require "treetop"
  require "mission_commands"

  belongs_to :mission
  belongs_to :user
  belongs_to :sheet

  memoize :sheet

  def parse mission_permalink
    @@parser ||= MissionCommandsParser.new
    p = @@parser.parse(self.data)
    event_type = p.try(:event_type) || "unknown"

    self.event_type = event_type
    begin send(event_type, p); rescue; end

    self.mission = Mission.find_or_create_by_permalink(mission_permalink)
  end

  def latest
    self.user.events.find(:first, :conditions => { :mission_id => self.mission}, :order => "created_at" )
  end

  def explode!
    
  end

  def modified
    self
  end

  private
  def unknown(parse)
    self.result = self.data
  end

  def roll(parse)
    dice = parse.dice
    size = parse.dice_size
    self.result = "#{(1..dice).inject([]){|result, n| result << rand(size) + 1}.sort!.join(' ')} (#{self.data})"
  end

  def setname(parse)
    name = parse.name
    sheet = self.user.sheets.find_or_create_by_name(name)
    self.user.update_attribute("latest_sheet_id", sheet.id) unless sheet.id.nil?
    self.sheet = sheet
    self.result = "set name to #{sheet.name}"
  end
end

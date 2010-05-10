class Event < ActiveRecord::Base
  require "treetop"
  require "mission_commands"

  belongs_to :mission
  belongs_to :user
  belongs_to :sheet

  def before_create
    p = parse(self.data)

    if p.event_type == "roll"
      self.event_type = p.event_type
      roll(p.dice, p.dice_size)
      puts self.inspect
    elsif p.event_type == "explode"
      latest.explode!
      return false
    else
      return false
    end
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

  def roll dice, size
    self.result = (1..dice).inject([]){|result, n| result << rand(size) + 1}.sort!.join(' ')
  end

  def parse(s)
    @parser ||= MissionCommandsParser.new
    @parser.parse s
  end

end

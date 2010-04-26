class Event < ActiveRecord::Base
  require "treetop"
  require "mission_commands"

  belongs_to :mission
  belongs_to :user
  belongs_to :sheet

  def before_create
    p = parse(self.data)
    self.event_type = p.event_type
    self.exploded = p.explode? if p.respond_to?(:explode?)
    self.result = case self.event_type
      when "roll" then (1..(p.dice)).inject([]){|result, n| result << rand(6) + 1}.sort!.join(' ')
      when "explode" then "explode!"
      when "set_obstacle" then p.obstacle
      when "set_goal" then p.goal
      when "quote" then "#{p.speaker} said: #{p.quote}"
      when "script" then "Has scripted!"
      when "set_disposition" then p.disposition
      when "adjust_disposition" then p.adjust_disposition
      else p.other
    end
    self.save
  end

  private
  def parse(s)
    @parser ||= MissionCommandsParser.new
    @parser.parse s
  end

end

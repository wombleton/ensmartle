module MissionsHelper
  require "treetop"
  require "mission_commands"
  def parse(s)
    @parser ||= MissionCommandsParser.new
    @parser.parse s
  end
end

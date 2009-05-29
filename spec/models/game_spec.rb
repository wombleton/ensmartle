require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Game do
  it "should have 1 as its permalink when passed 1" do
    game = Game.new
    game.generate_permalink(1).should eql('1')
    game.generate_permalink(62).should eql('10')
    game.generate_permalink(3844).should eql('100')
    game.generate_permalink(3854).should eql('10a')
  end
end
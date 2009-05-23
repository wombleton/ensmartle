require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Spell do
  before(:each) do
    @spell = Spell.new
    @valid_attributes = {
      :name => "Magic spell",
      :tradeskill => "Alchemy"
    }
  end

  it "should create a new instance given valid attributes" do
    @spell.attributes = @valid_attributes
    @spell.should have(0).errors
  end

  it "should fail without a name" do
    @spell.attributes = @valid_attributes.except(:name)
    @spell.should have(1).error_on(:name)
  end

  it "should fail without a tradeskill" do
    @spell.attributes = @valid_attributes.except(:tradeskill)
    @spell.should have(1).error_on(:tradeskill)
  end

  it "should have a recipes collection" do
    @spell.attributes = @valid_attributes
    @spell.recipes.should be_a_kind_of Array
  end

  it "should have a characters collection" do
    @spell.attributes = @valid_attributes
    @spell.professions.should be_a_kind_of Array
  end
end

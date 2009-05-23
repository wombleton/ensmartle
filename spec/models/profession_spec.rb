require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Profession do
  before(:each) do
    @character = Character.new
    @profession = Profession.new
    @spell = Spell.new
    @profession.stub!(:all_recipes).and_return([@spell])
    @valid_attributes = {
      :character => @character
    }
  end

  it "should create a new instance given valid attributes" do
    @profession.attributes = @valid_attributes
    @profession.should have(0).errors
  end

  it "should complain if it doesn't have a valid character" do
    @profession.attributes = @valid_attributes.except(:character)
    @profession.should have(1).error_on(:character)
  end

  it "should have a collection of recipes" do
    @profession.recipes.should be_a_kind_of Array
  end

  it "should have a collection of spells" do
    @profession.spells.should be_a_kind_of Array
  end

  it "should have an accessor for all_recipes" do
    @profession.all_recipes.should eql([@spell])
  end

end

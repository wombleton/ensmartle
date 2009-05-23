require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Recipe do
  before(:each) do
    @spell = Spell.new
    @profession = Profession.new
    @recipe = Recipe.new
    @valid_attributes = {
      :spell => @spell,
      :profession => @profession
    }
  end

  it "should create a new instance given valid attributes" do
    @recipe.attributes = @valid_attributes
  end

  it "should fail without a spell" do
    @recipe.attributes = @valid_attributes.except(:spell)
    @recipe.should have(1).error_on(:spell)
  end

  it "should fail without a profession" do
    @recipe.attributes = @valid_attributes.except(:profession)
    @recipe.should have(1).error_on(:profession)
  end
end

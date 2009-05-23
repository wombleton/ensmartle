require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class MockCharacter
  attr_accessor :professions, :name, :guild

  def initialize
    self.professions = []
    self.name ="Haft"
    self.name ="Carpe Jugulum"
  end
end

describe Character do
  before(:each) do
    @character = Character.new
    @valid_attributes = {
      :name => "Haft",
      :realm => Realm.create(:name => "Proudmoore", :locale => "US")
    }

    @api_character = MockCharacter.new
    @api_character.professions << Wowr::Classes::Skill.new(:name => "Blacksmithing", :value => 400, :max => 450)
    @api_character.professions << Wowr::Classes::Skill.new(:name => "Mining", :value => 450, :max => 450)
  end

  it "should create a new instance given valid attributes" do
    @character.attributes = @valid_attributes
    @character.should have(0).errors
  end

  it "should fail without a name" do
    @character.attributes = @valid_attributes.except(:name)
    @character.should have(1).error_on(:name)
  end

  it "should fail without a realm" do
    @character.attributes = @valid_attributes.except(:realm)
    @character.should have(1).error_on(:realm)
  end

  it "should respond to armoury_url" do
    @character.attributes = @valid_attributes
    @character.should respond_to(:armoury_url)
  end

  it "should respond to guild" do
    @character.attributes = @valid_attributes
    @character.should respond_to(:guild)
  end

  it "should have a pseudo_id" do
    @character.attributes = @valid_attributes
    @character.should respond_to(:pseudo_id)
  end

  it "should have the correct pseudo_id" do
    @character.attributes = @valid_attributes
    @character.save!
    @character.pseudo_id.should eql("haft")
  end

  it "should update professions from wowr" do
    api = Wowr::API.new(:caching => false, :locale => "us")
    Wowr::API.stub!(:new).and_return(api)
    api.stub!(:get_character).and_return(@api_character)
    @character.attributes = @valid_attributes
    @character.save!
    @character.update_professions
    @character.professions.size.should eql(2)
  end

  it "should have a collection of recipes" do
    @character.attributes = @valid_attributes
    @character.save
    @character.recipes.should be_a_kind_of Array
  end

  it "should not lose learnt recipes when updating twice" do
    api = Wowr::API.new(:caching => false, :locale => "us")
    Wowr::API.stub!(:new).and_return(api)
    api.stub!(:get_character).and_return(@api_character)
    @character.attributes = @valid_attributes
    @character.save!
    @character.update_professions
    @character.professions.size.should eql(2)
    @character.professions.first.recipes << Recipe.new
    @character.save
    @character.professions.first.recipes.size.should eql(1)
    @character.update_professions
    @character.save
    @character.professions.size.should eql(2)
    @character.professions.first.recipes.size.should eql(1)
  end
end

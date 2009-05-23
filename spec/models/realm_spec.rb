require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Realm do
  before(:each) do
    @valid_attributes = {
      :name => "Fuzzy Wuzzy",
      :locale => "US"
    }
    @realm = Realm.new
  end

  it "should create a new instance given valid attributes" do
    @realm.attributes = @valid_attributes
  end

  it "should not work without a locale" do
    @realm.attributes = @valid_attributes.except(:locale)
    @realm.should have(1).error_on(:locale)
  end

  it "should not work without a name" do
    @realm.attributes = @valid_attributes.except(:name)
    @realm.should have(1).error_on(:name)
  end

  it "should have a pseudo_id" do
    @realm.attributes = @valid_attributes
    @realm.should respond_to(:pseudo_id)
  end

  it "should have the right pseudo_id" do
    @realm.attributes = @valid_attributes
    @realm.save
    @realm.pseudo_id.should eql("fuzzy-wuzzy-us")
  end
end

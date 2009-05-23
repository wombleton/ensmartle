require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CharactersController, "#route_for" do
  it "should map {:controller => 'characters', :action => :search} to /armourysearch" do
    route_for(:controller => "characters", :action => "search").should == "/armourysearch"
  end

  it "should map {:controller => 'characters', :action => :show, :realm_id => 'foo', :id => 'bar'} to /realms/foo/bar" do
    route_for(:controller => "characters", :action => "show", :id => "bar", :realm_id => "foo").should == "/realms/foo/bar"
  end
end

describe CharactersController, "handling POST /characters/search" do
  
end

describe CharactersController, "handling GET /realm/proudmoore-us/haft" do
  before do
    @realm = mock_model(Realm, :locale => "us", :name => "proudmoore", :save => true)
    @character = mock_model(Character, :to_param => "haft", :professions => [], :realm => @realm)
    @character.stub!(:update_professions)
    @weezly = mock_model(Character, :to_param => "weezly", :professions => [], :realm => @realm)
    @weezly.stub!(:update_professions)
    Realm.stub!(:find_by_pseudo_id).and_return(@realm)
    Character.stub!(:find_or_create_by_name).and_return(@character)
  end

  def do_get name = "haft"
    get :show, :id => name, :realm_id => "proudmoore-us"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end

  it "should render show template" do
    do_get
    response.should render_template('show')
  end

  it "should find the character requested" do
    Character.should_receive(:find_or_create_by_name).with("haft", {:include => :professions, :conditions => {:realm_id => @realm.id}}).and_return(@character)
    do_get
  end

  it "should update professions from wowr" do
    @character.should_receive(:update_professions)
    do_get
  end

  it "should redirect to armoury fail when Wowr throws an error" do
    @character.should_receive(:update_professions).and_raise(Timeout::Error)
    do_get
    response.should redirect_to(:action => "armoury_fail")
  end

  it "should add a character if it's valid from the armoury" do
    Character.should_receive(:find_or_create_by_name).with("weezly", {:include => :professions, :conditions => {:realm_id => @realm.id}}).and_return(@weezly)
    do_get "weezly"
  end
end
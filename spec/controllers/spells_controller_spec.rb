require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SpellsController, "#route_for" do
  it "should map {:controller => 'spells', :action => 'tooltip', :id => 'foo'} to '/spells/foo/tooltip'" do
    route_for(:controller => "spells", :action => "tooltip", :id => "foo").should == "/spells/foo/tooltip"
  end

  it "should map {:controller => spells, :action => :search} to '/search'" do
    route_for(:controller => "spells", :action => "search").should == "/search"
  end
end

describe SpellsController, "handling GET /search" do
  before do
    @spell = mock_model(Spell, :to_param => "mining", :name => "Mining", :save => true)
    @character = mock_model(Character, :to_param => "haft", :name => "Haft", :save => true)
  end

  def do_search
    get :search, :query => "min"
  end

  it "should render template search" do
    do_search
    response.should render_template('searc')
  end



  it "should find @spell with search of 'min'" do
    Spell.should_receive(:find).and_return([@spell])
    Character.should_receive(:find).and_return([])
    do_search
    assigns[:results].should == [@spell]
  end
end

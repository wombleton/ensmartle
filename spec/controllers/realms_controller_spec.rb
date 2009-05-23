require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RealmsController, "#route_for" do
  it "should map {:controller => 'realms', :action => :index} to /realms" do
    route_for(:controller => "realms", :action => "index").should eql("/realms")
  end

  it "should map {:controller => 'realms', :action => :show, :id => 'foo'} to /realms/foo" do
    route_for(:controller => "realms", :action => "show", :id => "foo").should eql("/realms/foo")
  end
end

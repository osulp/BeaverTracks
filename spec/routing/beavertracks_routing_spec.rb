require 'spec_helper'

describe "routing for Beavertracks" do
  it "should be the root route" do
    { :get => '/' }.should route_to(:controller => 'beavertracks', :action => 'index')
  end
end

describe "routing for buildings" do
  it "routes /buildings/:id/image to buildings#image for id" do
    expect(:get => "/buildings/2/image").to route_to(
      :controller => "buildings",
      :action => "image",
      :id => "2"
    )
  end

#  it "does not expose a list of profiles" do
#    expect(:get => "/profiles").not_to be_routable
#  end
end


describe "routing for maps" do
  it "routes /maps/:id/locations to maps#locations" do
    expect(:get => "/maps/5/locations").to route_to(
      :controller => "maps",
      :action => "locations",
      :id => "5"
    )
  end
end

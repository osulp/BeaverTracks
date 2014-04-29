require 'spec_helper'

describe "Buildings" do
  before(:each) do

    @langton = create(:buildings, name: "Langton Hall", lat: 44.5641250610352, lng: -123.278312683105)
    @waldo = create(:buildings, name: "Waldo Hall", lat: 44.5641059875488, lng: -123.277206420898)
    @moreland = create(:buildings, name: "Moreland Hall", lat: 44.5642700195312, lng: -123.279388427734)
    @goss = create(:buildings, name: "Goss Stadium at Coleman Field & Dixon Recreation Center", lat: 44.5632972717285, lng: -123.277648925781)
    @fairbanks = create(:buildings, name: "Fairbanks Hall", lat: 44.5650672912598, lng: -123.280410766602)
    @weatherford = create(:buildings, name: "Weatherford Hall", lat: 44.5640335083008, lng: -123.280639648438)

    @patron = create(:patron)
  end
    

  it "should return buildings sorted in name order" do
    expect(Buildings.list()).to eq([@fairbanks, @goss, @langton, @moreland, @waldo, @weatherford])
  end

  it "should return nearby buildings plus original" do
    expect(Buildings.nearby(@langton)).to eq([@langton, @waldo, @moreland, @goss])
  end

  it "should return buildings nearby Patron" do
    expect(Buildings.nearby([@patron.lat, @patron.lng])).to eq([@langton, @waldo, @moreland, @goss])
  end

end

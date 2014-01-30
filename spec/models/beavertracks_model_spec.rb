require 'spec_helper'

describe "Buildings" do

    Langton = Buildings.create(lat: 44.5641250610352, lng: -123.278312683105, name: "Langton Hall")
    Waldo = Buildings.create(lat: 44.5641059875488, lng: -123.277206420898, name: "Waldo Hall")
    Moreland = Buildings.create(lat: 44.5642700195312, lng: -123.279388427734, name: "Moreland Hall")
    Goss = Buildings.create(lat: 44.5632972717285, lng: -123.277648925781, name: "Goss Stadium at Coleman Field & Dixon Recreation Center")
    Fairbanks = Buildings.create(lat: 44.5650672912598, lng: -123.280410766602, name: "Fairbanks Hall")
    Weatherford = Buildings.create(lat: 44.5640335083008, lng: -123.280639648438, name: "Weatherford Hall")


  it "should return buildings sorted in name order" do
    expect(Buildings.list()).to eq([Fairbanks, Goss, Langton, Moreland, Waldo, Weatherford])
  end

  it "should return nearby buildings plus original" do
    expect(Buildings.nearby(Langton)).to eq([Langton, Waldo, Moreland, Goss])
  end
end

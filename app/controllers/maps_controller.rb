class MapsController < ApplicationController

  def index
    @title = "Map"

#    @json = Buildings.all.to_gmaps4rails

    @json = Buildings.all.to_gmaps4rails do |building, marker|
      marker.json({ :id => building.id, :title => building.name })
    end
  end


end

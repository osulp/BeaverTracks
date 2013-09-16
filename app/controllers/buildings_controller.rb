class BuildingsController < ApplicationController
  def index
    @title = "Building List"

    @buildings = Buildings.list
  end

  def show
    @building = Buildings.find(params[:id])
    
    # flickr ID as constant?

    @title = @building.name
  end

  def image
    @building = Buildings.find(params[:id])

    @title = @building.name + " - Large Image"
  end
end

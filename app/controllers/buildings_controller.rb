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
end

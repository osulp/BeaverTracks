class MapsController < ApplicationController

  def index
    @title = "Map"

    @json = Buildings.all.to_gmaps4rails do |building, marker|
      marker.json({ :id => building.id, :title => building.name })
    end
  end



# Map of Nearby Locations

  def locations
    @building = Buildings.find(params[:id])
    @meta_keywords = @title = @meta_description = "Nearby " + @building.name
    
    @nearby_buildings = Buildings.nearby(@building)

    # set building markers, different one for selected building
    @json = @nearby_buildings.to_gmaps4rails do |building, marker|
      marker.json({ :id => building.id, :title => building.name })

      if @building.id === building.id
        marker.picture({
          "picture" => ActionController::Base.helpers.asset_path('home/image.png'),
          "width" => 32, 
          "height" => 37,
          "marker_anchor" => [5, 10],
          "shadow_picture" => ActionController::Base.helpers.asset_path('location/shadow.png'),
          "shadow_width" => 51,
          "shadow_height" => 37,
          "shadow_anchor" => [5, 10]
        })
      end
    end
    
  end

end

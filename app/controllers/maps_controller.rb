class MapsController < ApplicationController

  def index
    @title = "Map"

#    @buildings = User.all
    @hash = Gmaps4rails.build_markers(Buildings.all) do |building, marker|
      marker.lat building.lat
      marker.lng building.lng
#      marker.id building.id
      marker.title building.name
    end

#    @json = Buildings.all.to_gmaps4rails do |building, marker|
#      marker.json({ :id => building.id, :title => building.name })
#      marker.infowindow render_to_string(:partial => "maps/infowindow", :locals => { :building => building })
#    end
  end



# Map of Nearby Locations

  def locations
    @building = Buildings.find(params[:id])

    @title = "Nearby " + @building.name

    @hash = Gmaps4rails.build_markers(Buildings.nearby(@building)) do |building, marker|
      marker.lat building.lat
      marker.lng building.lng
      marker.title building.name
    end


    # set building markers, different one for selected building
#    @json = Buildings.nearby(@building).to_gmaps4rails do |building, marker|
#      marker.json({ :id => building.id, :title => building.name })
#      marker.infowindow render_to_string(:partial => "maps/infowindow", :locals => { :building => building })

#      if @building.id === building.id
#        marker.picture({
#          "picture" => ActionController::Base.helpers.asset_path('arrow.png'),
#          "width" => 32,
#          "height" => 37,
#          "marker_anchor" => [5, 10],
#          "shadow_picture" => ActionController::Base.helpers.asset_path('shadow.png'),
#          "shadow_width" => 51,
#          "shadow_height" => 37,
#          "shadow_anchor" => [5, 10]
#        })
#      end
#    end

  end


# Walking Tour
# Redirected here directly from Patron Controller, function redirect_patron()

  def tour
    @title = "Walking Tour"

    @patron = Patron.from_coords(session)

    @hash = Gmaps4rails.build_markers(Buildings.all) do |building, marker|
      marker.lat building.lat
      marker.lng building.lng
#      marker.id building.id
      marker.title building.name
    end


    # set markers, walking icon for patron location
#    @json = (Buildings.nearby(@patron) | [@patron]).to_gmaps4rails do |building, marker|
#      if building.kind_of? Buildings
#        marker.json({ :id => building.id, :title => building.name })
#        marker.infowindow render_to_string(:partial => "maps/building_tour_infowindow", :locals => { :building => building })
#      end
#
#      if building.kind_of? Patron
#        marker.json({ :id => building.id, :title => "You" })
#
#        marker.picture({
#          "picture" => ActionController::Base.helpers.asset_path('walking.png'),
#          "width" => 32,
#          "height" => 37,
#          "marker_anchor" => [5, 10],
#          "shadow_picture" => ActionController::Base.helpers.asset_path('shadow.png'),
#          "shadow_width" => 51,
#          "shadow_height" => 37,
#          "shadow_anchor" => [5, 10]
#        })
#
#        marker.infowindow render_to_string(:partial => "maps/patron_tour_infowindow", :locals => { :building => building })
#      end
#
#    end

    @on_campus = session[:campus]

    session[:campus] = nil
  end



  # Walking directions from patron location
  def directions
    @title = "Walking Directions"

    @patron = Patron.from_coords(session)

    @target_building = Buildings.find(params[:target_building_id])

  end

end

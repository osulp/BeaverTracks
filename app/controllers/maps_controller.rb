class MapsController < ApplicationController

  def index
    @title = "Map"

    @json = Buildings.all.to_gmaps4rails do |building, marker|
      marker.json({ :id => building.id, :title => building.name })
      marker.infowindow render_to_string(:partial => "maps/infowindow", :locals => { :building => building })
    end
  end



# Map of Nearby Locations

  def locations
    @building = Buildings.find(params[:id])

    @title = "Nearby " + @building.name
    
    # set building markers, different one for selected building
    @json = Buildings.nearby(@building).to_gmaps4rails do |building, marker|
      marker.json({ :id => building.id, :title => building.name })
      marker.infowindow render_to_string(:partial => "maps/infowindow", :locals => { :building => building })

      if @building.id === building.id
        marker.picture({
          "picture" => ActionController::Base.helpers.asset_path('arrow.png'),
          "width" => 32, 
          "height" => 37,
          "marker_anchor" => [5, 10],
          "shadow_picture" => ActionController::Base.helpers.asset_path('shadow.png'),
          "shadow_width" => 51,
          "shadow_height" => 37,
          "shadow_anchor" => [5, 10]
        })
      end
    end
    
  end


# Walking Tour
# Redirected here directly from Patron Controller, function redirect_patron()

  def tour
    @title = "Walking Tour"

    @patron = Patron.find(params[:id])


    # set building markers, different one for selected building
    @json = Buildings.nearby(@patron).to_gmaps4rails do |building, marker|
      marker.json({ :id => building.id, :title => building.name })

        # change to different infowindow for tour
      marker.infowindow render_to_string(:partial => "maps/infowindow", :locals => { :building => building })

#      if @patron.id === building.id
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
#      end
    end


    #create icon
#    @map.icon_global_init(GIcon.new(:image => "/images/walking/image.png",
#      :shadow => "/images/walking/shadow.png",
#      :iconSize => GSize.new(32,37),
#      :shadow_size => GSize.new(51,37),
#      :icon_anchor => GPoint.new(16,37),
#      :transparent => "/images/walking/transparent.png",
#      :info_window_anchor => GPoint.new(16,0)),
#      "patron_icon")
#       patron_icon = Variable.new("patron_icon")

       #build direction info
#       info = direction_info(@patron.id)

       #create the marker with lat/long and info
#       mark = GMarker.new([@patron.lat,@patron.lng], 
#       :icon => patron_icon,
#       :title => "My Location",
#       :info_window => "#{info}")

    #add patron marker
#    @map.overlay_init(mark)

    #build buildings markers
#    location_icon = building_marker(@map)
#    @buildings.each do |building|
#      loc = building.lat.to_s+','+building.lng.to_s
#      info = building_direction_info(@patron.id,loc)
#      url = url_for(building)
#      mark =  building.create_marker(url,location_icon, info)
#      @map.overlay_init(mark)
#    end  

    @on_campus = session[:campus]

    session[:campus] = nil

  end

end

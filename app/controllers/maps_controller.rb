class MapsController < ApplicationController
  def index
    @title = 'Map'

    # Create markers for all Buildings
    @hash = Gmaps4rails.build_markers(Buildings.all) do |building, marker|
      marker.lat building.lat
      marker.lng building.lng
      marker.title building.name

      marker.picture(
                      'url' => ActionController::Base.helpers.asset_path('home.png'),
                      'width' =>  32,
                      'height' => 37,
                      'marker_anchor' => [5, 10],
                      'shadow_picture' => ActionController::Base.helpers.asset_path('location/shadow.png'),
                      'shadow_width' => 51,
                      'shadow_height' => 37,
                      'shadow_anchor' => [5, 10]
      )
      marker.infowindow render_to_string(partial: 'maps/infowindow', locals: { building: building })
    end
  end

  # Map of Nearby Locations
  def locations
    @building = Buildings.find(params[:id])

    @title = 'Nearby ' + @building.name

    # set building markers, using different one for selected building
    @hash = Gmaps4rails.build_markers(Buildings.nearby(@building)) do |building, marker|
      marker.lat building.lat
      marker.lng building.lng
      marker.title building.name

      if @building.id == building.id
        marker.picture(
                        'url' => ActionController::Base.helpers.asset_path('arrow.png'),
                        'width' => 32,
                        'height' => 37,
                        'marker_anchor' => [5, 10],
                        'shadow_picture' => ActionController::Base.helpers.asset_path('shadow.png'),
                        'shadow_width' => 51,
                        'shadow_height' => 37,
                        'shadow_anchor' => [5, 10]
        )
      else
        marker.picture(
                        'url' => ActionController::Base.helpers.asset_path('home.png'),
                        'width' =>  32,
                        'height' => 37,
                        'marker_anchor' => [5, 10],
                        'shadow_picture' => ActionController::Base.helpers.asset_path('location/shadow.png'),
                        'shadow_width' => 51,
                        'shadow_height' => 37,
                        'shadow_anchor' => [5, 10]
        )
      end

      marker.infowindow render_to_string(partial: 'maps/infowindow', locals: { building: building })
    end
  end

# Walking Tour
# Redirected here directly from Patron Controller, function redirect_patron()

  def tour
    @title = 'Walking Tour'

    @patron = Patron.from_coords(session)

    # set markers, using walking icon for patron location
    @hash = Gmaps4rails.build_markers(Buildings.nearby([@patron.lat, @patron.lng]) | [@patron]) do |building, marker|

      if building.kind_of? Buildings
        marker.lat building.lat
        marker.lng building.lng
        marker.title building.name

        marker.picture(
                        'url' => ActionController::Base.helpers.asset_path('home.png'),
                        'width' =>  32,
                        'height' => 37,
                        'marker_anchor' => [5, 10],
                        'shadow_picture' => ActionController::Base.helpers.asset_path('location/shadow.png'),
                        'shadow_width' => 51,
                        'shadow_height' => 37,
                        'shadow_anchor' => [5, 10]
        )

        marker.infowindow render_to_string(partial: 'maps/building_tour_infowindow', locals: { building: building })

      else
        marker.lat building.lat
        marker.lng building.lng
        marker.title 'You'

        marker.picture(
                        'url' => ActionController::Base.helpers.asset_path('walking.png'),
                        'width' => 32,
                        'height' => 37,
                        'marker_anchor' => [5, 10],
                        'shadow_picture' => ActionController::Base.helpers.asset_path('shadow.png'),
                        'shadow_width' => 51,
                        'shadow_height' => 37,
                        'shadow_anchor' => [5, 10]
        )

        marker.infowindow render_to_string(partial: 'maps/patron_tour_infowindow',
                                           locals: { building: building })
      end
    end

    @on_campus = session[:campus]

    session[:campus] = nil
  end

  # Walking directions from patron location
  def directions
    @title = 'Walking Directions'

    @patron = Patron.from_coords(session)

    @target_building = Buildings.find(params[:target_building_id])
  end
end

class PatronsController < ApplicationController

  def new
    @title = 'Retrieving Location'

    session[:patron] = nil
    @patron =  Patron.new

    # test if on campus
  #  @lat = session[:geo_location] != nil ? session[:geo_location].lat : ""
  #  @lng = session[:geo_location] != nil ? session[:geo_location].lng : ""
  end

  def create
    # render text: params[:patron].inspect
    @patron = Patron.new(params[:patron])

    @patron.save

    session[:patron] = @patron

    redirect_patron(@patron.id)
  end



  # param @patron 
  # checks if oncampus, and redirects to show/tour map
 
  def redirect_patron(id)
    patron = Patron.find(id)
    buildings = Buildings.nearby(patron)
     
    #see if on campus
    if buildings.count > 0
      session[:campus] = true
    else
      #set location to library
      session[:campus] = false
      patron.lat = 44.5650618928
      patron.lng = -123.27603917
      patron.save
    end

    redirect_to(tour_map_path(patron))
  end

end

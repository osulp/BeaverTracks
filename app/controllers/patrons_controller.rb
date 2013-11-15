class PatronsController < ApplicationController
  before_filter :generate_patron
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
    #@patron = Patron.new(params[:patron])

    #@patron.save

    #session[:patron] = @patron
    session['lat'] = params[:patron][:lat]
    session['lng'] = params[:patron][:lng]
    @patron = Patron.from_coords(params[:patron])
    redirect_patron(@patron)
  end



  # param @patron
  # checks if oncampus, and redirects to show/tour map

  def redirect_patron(patron)
    buildings = Buildings.nearby(patron)

    #see if on campus
    if buildings.count > 0
      session[:campus] = true
    else
      #set location to library
      session[:campus] = false
      session[:lat] = 44.5650618928
      session[:lng] = -123.27603917
      patron = Patron.from_coords(session)
    end

    redirect_to(tour_maps_path)
  end

  private

  def generate_patron
    if session[:lat] && session[:lng]
      @patron = Patron.from_coords(:lat => session[:lat], :lng => session[:lng])
    end
  end

end

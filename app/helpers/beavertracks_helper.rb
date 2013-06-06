module BeavertracksHelper
  
  def nearby_path
    if session[:patron] != nil
      tour_map_path(session[:patron])
    else
      new_patron_url
    end
  end
  
end

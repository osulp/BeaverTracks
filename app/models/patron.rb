class Patron < ActiveRecord::Base
    acts_as_mappable :default_units => :miles, 
                   :default_formula => :sphere, 
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng



  #check if patron is within 1 mile of
  #the campus sites
  def on_campus(lat, lng)
      buildings =  Building.find(:all, :origin => [lat,lng], :within => 1)
      if buildings.blank?
        return false
      end
     return true
  end


  
 
end

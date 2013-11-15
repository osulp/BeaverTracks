class Buildings < ActiveRecord::Base
  attr_accessible :id, :description, :flickr_orig_url, :flickr_tag, :flickr_thumb_url, :lat, :lng, :name, :search_tags

  scope :list, :order => :name

  geocoded_by :name, :latitude => :lat, :longitude => :lng 

  # GMaps4Rails - Configure to use lat and lng fields 
  acts_as_gmappable :lat => "lat", :lng => "lng", :process_geocoding => false

  # Return 3 nearby buildings 
  def self.nearby(obj) 
     return Buildings.near(obj, 1)[0..3]  # 3 buildings and itself
  end 
  

  def gmaps4rails_marker_picture
  {
    "picture" => ActionController::Base.helpers.asset_path('home.png'),
    "width" => 32,
    "height" => 37,
    "marker_anchor" => [5, 10],
    "shadow_picture" => ActionController::Base.helpers.asset_path('location/shadow.png'),
    "shadow_width" => 51,
    "shadow_height" => 37,
    "shadow_anchor" => [5, 10]
  }
  end

end

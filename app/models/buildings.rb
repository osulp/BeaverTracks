class Buildings < ActiveRecord::Base
  attr_accessible :id, :description, :flickr_orig_url, :flickr_tag, :flickr_thumb_url, :lat, :lng, :name, :search_tags

  scope :list, -> {order('name')}

  geocoded_by :name, :latitude => :lat, :longitude => :lng 

  # Return 3 nearby buildings 
  def self.nearby(obj) 
     return Buildings.near(obj, 1)[0..3]  # 3 buildings and itself
  end 

end

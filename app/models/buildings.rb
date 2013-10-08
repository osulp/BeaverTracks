class Buildings < ActiveRecord::Base
  attr_accessible :id, :description, :flickr_orig_url, :flickr_tag, :flickr_thumb_url, :lat, :lng, :name, :search_tags

  scope :list, :order => :name

  # Configure to use lat and lng fields
  acts_as_gmappable :lat => "lat", :lng => "lng", :process_geocoding => false

end

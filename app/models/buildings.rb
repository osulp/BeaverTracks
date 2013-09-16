class Buildings < ActiveRecord::Base
  attr_accessible :description, :flickr_orig_url, :flickr_tag, :flickr_thumb_url, :lat, :lng, :name, :search_tags

  scope :list, :order => :name
end

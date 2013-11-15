class Patron < ActiveRecord::Base
  attr_accessible :city, :country, :distance, :lat, :lng, :locality, :state, :street, :zip

  geocoded_by :address, :latitude => :lat, :longitude => :lng

  # GMaps4Rails - Configure to use lat and lng fields
  acts_as_gmappable :lat => "lat", :lng => "lng", :process_geocoding => false

  def self.from_coords(opts={})
    new(:lat => opts[:lat], :lng => opts[:lng])
  end

  def address
      [street, city, state, zip, country].compact.join(', ')
  end

end

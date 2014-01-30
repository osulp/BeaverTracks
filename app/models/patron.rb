class Patron < ActiveRecord::Base
  attr_accessible :city, :country, :distance, :lat, :lng, :locality, :state, :street, :zip

  geocoded_by :address, :latitude => :lat, :longitude => :lng

  def self.from_coords(opts={})
    new(:lat => opts[:lat], :lng => opts[:lng])
  end

  def address
      [street, city, state, zip, country].compact.join(', ')
  end

end

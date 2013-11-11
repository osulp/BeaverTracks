class Patron < ActiveRecord::Base
  attr_accessible :city, :country, :distance, :lat, :lng, :locality, :state, :street, :zip
end

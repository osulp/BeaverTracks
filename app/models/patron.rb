# Patron, for placing on map and starting walking tour
class Patron < OpenStruct
  # Create Patron when passed coords
  # @param [List] lat and lng coordinates
  # @return [OpenStruct] new Patron OpenStruct
  def self.from_coords(opts = {})
    OpenStruct.new(lat: opts[:lat], lng: opts[:lng])
  end
end

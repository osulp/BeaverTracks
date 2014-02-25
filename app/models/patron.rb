class Patron < OpenStruct

  def self.from_coords(opts={})
    new(:lat => opts[:lat], :lng => opts[:lng])
  end

end

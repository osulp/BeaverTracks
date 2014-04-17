class Patron < OpenStruct

  def self.from_coords(opts={})
    OpenStruct.new(:lat => opts[:lat], :lng => opts[:lng])
  end

end

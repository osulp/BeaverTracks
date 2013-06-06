class AddIndexOfPatronLatAndLng < ActiveRecord::Migration
  def self.up
    add_index  :patrons, [:lat, :lng]
    add_index  :buildings, [:lat, :lng]
  end

  def self.down
    remove_index  :patrons, [:lat, :lng]
    remove_index  :buildings, [:lat, :lng]
  end

end

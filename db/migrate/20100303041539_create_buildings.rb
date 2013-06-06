class CreateBuildings < ActiveRecord::Migration
  def self.up
    create_table :buildings do |t|
      t.float :lat
      t.float :lng
      t.string :flickr_url
      t.string :og_url
      t.string :name
      t.text :description
      t.string :tag
      t.string :search_tags
      t.float :distance

      t.timestamps
    end
  end

  def self.down
    drop_table :buildings
  end
end

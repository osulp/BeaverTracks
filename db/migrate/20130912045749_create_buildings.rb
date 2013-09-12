class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :name
      t.text :description
      t.string :flickr_thumb_url
      t.string :flickr_orig_url
      t.string :flickr_tag
      t.string :search_tags
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end

class CreatePatrons < ActiveRecord::Migration
  def change
    create_table :patrons do |t|
      t.float :distance
      t.string :street
      t.string :locality
      t.string :city
      t.string :state
      t.string :country
      t.string :zip
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end

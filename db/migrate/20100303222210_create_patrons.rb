class CreatePatrons < ActiveRecord::Migration
  def self.up
    create_table :patrons do |t|
      t.float :distance
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end

  def self.down
    drop_table :patrons
  end
end

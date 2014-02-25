class RemovePatronsTable < ActiveRecord::Migration

  def change
    drop_table :patrons
  end

end

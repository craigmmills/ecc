class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.decimal :venue_lat
      t.decimal :venue_lng
      t.text :conditions

      t.timestamps
    end
  end
end

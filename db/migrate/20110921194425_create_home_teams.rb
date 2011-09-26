class CreateHomeTeams < ActiveRecord::Migration
  def change
    create_table :home_teams do |t|
      t.string :name

      t.timestamps
    end
  end
end

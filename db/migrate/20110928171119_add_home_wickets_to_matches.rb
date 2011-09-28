class AddHomeWicketsToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :home_wickets, :integer
  end
end

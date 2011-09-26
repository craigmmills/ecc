class AddMatchdateToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :match_date, :date
  end
end

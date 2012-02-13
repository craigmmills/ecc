class AddPlaycrickurlToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :url, :string
  end
end

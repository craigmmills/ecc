class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :description
      t.string :mob_num
      t.string :home_num

      t.timestamps
    end
  end
end

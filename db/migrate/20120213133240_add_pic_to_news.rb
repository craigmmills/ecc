class AddPicToNews < ActiveRecord::Migration
  def self.up
    change_table :news do |t|
      t.has_attached_file :pics
    end
  end

  def self.down
    drop_attached_file :news, :pics
  end
end

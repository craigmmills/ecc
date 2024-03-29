class Player < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  has_and_belongs_to_many :our_teams
  
  scope :player_list, order("last_name").where("hide = false or hide IS NULL")
  
  
end

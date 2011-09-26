class Team < ActiveRecord::Base
  has_many :matches
  belongs_to :venue
end

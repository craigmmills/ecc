class Venue < ActiveRecord::Base
  has_many :teams
  has_many :matches
end

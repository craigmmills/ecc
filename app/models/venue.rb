class Venue < ActiveRecord::Base
  has_many :opposition
  has_many :matches
end

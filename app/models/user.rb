class User < ActiveRecord::Base
  geocoded_by      :address
  after_validation :geocode
  has_many :comments
end

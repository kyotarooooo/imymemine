class Coordinate < ApplicationRecord
	belongs_to :user
	attachment :coordinate_image
end

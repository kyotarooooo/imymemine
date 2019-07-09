class Coordinate < ApplicationRecord
	belongs_to :user
	attachment :coordinate_image

	validates :coordinate_image, presence: true
	validates :body, presence: true
end


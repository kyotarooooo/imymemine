class Coordinate < ApplicationRecord
	belongs_to :user
	has_many :items, dependent: :destroy
	accepts_nested_attributes_for :items
	attachment :coordinate_image

	validates :coordinate_image, presence: true
	validates :body, presence: true

	def self.search(search)
		if search
			Coordinate.where(['body LIKE ?', "%#{search}%"])
		else
			Coordinate.all
		end
	end
end


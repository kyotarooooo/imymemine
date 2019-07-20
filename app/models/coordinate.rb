class Coordinate < ApplicationRecord
	belongs_to :user
	has_many :items, inverse_of: :coordinate
	accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true
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


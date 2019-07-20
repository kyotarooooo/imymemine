class Item < ApplicationRecord
	belongs_to :coordinate
	attachment :item_image
end

class Like < ApplicationRecord
  belongs_to :coordinate
  belongs_to :user

  #いいね機能
  validates_uniqueness_of :coordinate_id, scope: :user_id
end

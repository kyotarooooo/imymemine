class AddBodyToCoordinates < ActiveRecord::Migration[5.2]
  def change
    add_column :coordinates, :body, :text
    add_column :coordinates, :coordinate_image_id, :text
  end
end

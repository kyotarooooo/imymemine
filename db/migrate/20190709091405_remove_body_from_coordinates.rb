class RemoveBodyFromCoordinates < ActiveRecord::Migration[5.2]
  def change
    remove_column :coordinates, :body, :text
    remove_column :coordinates, :coordinate_image_id, :text
  end
end

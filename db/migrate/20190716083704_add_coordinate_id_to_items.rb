class AddCoordinateIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :coordinate_id, :integer
  end
end

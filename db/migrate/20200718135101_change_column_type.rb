class ChangeColumnType < ActiveRecord::Migration[5.2]
  def change
    remove_column :markets, :lat
    remove_column :markets, :lng
    add_column :markets, :latitude, :float
    add_column :markets, :longitude, :float 
  end
end

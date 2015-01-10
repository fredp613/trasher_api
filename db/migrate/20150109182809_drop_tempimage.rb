class DropTempimage < ActiveRecord::Migration
  def change
  	drop_table :temp_images
  end
end

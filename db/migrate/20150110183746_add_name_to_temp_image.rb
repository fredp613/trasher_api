class AddNameToTempImage < ActiveRecord::Migration
  def change
  	add_column :temp_images, :name, :string
  end
end

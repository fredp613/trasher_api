class AddNameToTrashImage < ActiveRecord::Migration
  def change
  	add_column :trash_images, :name, :string
  end
end

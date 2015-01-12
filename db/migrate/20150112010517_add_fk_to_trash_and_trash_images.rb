class AddFkToTrashAndTrashImages < ActiveRecord::Migration
  def change
  	add_foreign_key :trashes, :users, :column => :created_by
  	add_foreign_key :trashes, :users, :column => :updated_by

  	add_foreign_key :trash_images, :users, :column => :created_by
  	add_foreign_key :trash_images, :users, :column => :updated_by
  end
end

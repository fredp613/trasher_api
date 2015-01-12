class AddUserToTables < ActiveRecord::Migration
  def change
  	add_column :trashes, :created_by, :integer
  	add_column :trashes, :updated_by, :integer

  	add_column :trash_images, :created_by, :integer
  	add_column :trash_images, :updated_by, :integer

  end
end

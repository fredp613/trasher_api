class RemoveFksTi < ActiveRecord::Migration
  def change
  	remove_foreign_key :trash_images, column: :created_by
  	remove_foreign_key :trash_images, column: :updated_by
  end
end

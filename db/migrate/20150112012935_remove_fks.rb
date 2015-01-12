class RemoveFks < ActiveRecord::Migration
  def change
  	remove_foreign_key :trashes, column: :created_by
  	remove_foreign_key :trashes, column: :updated_by
  end
end

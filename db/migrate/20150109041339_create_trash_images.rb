class CreateTrashImages < ActiveRecord::Migration
  def change
    create_table :trash_images do |t|
      t.string :trash_image
      t.references :trash, index: true

      t.timestamps null: false
    end
    add_foreign_key :trash_images, :trashes
  end
end

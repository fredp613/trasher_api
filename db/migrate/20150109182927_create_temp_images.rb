class CreateTempImages < ActiveRecord::Migration
  def change
    create_table :temp_images do |t|
      t.string :image
      t.string :temp_id

      t.timestamps null: false
    end
  end
end

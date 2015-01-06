class CreateTrashes < ActiveRecord::Migration
  def change
    create_table :trashes do |t|
      t.string :title
      t.string :description
      t.string :catetory_id
      t.boolean :trash_type

      t.timestamps null: false
    end
  end
end

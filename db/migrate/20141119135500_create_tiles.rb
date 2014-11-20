class CreateTiles < ActiveRecord::Migration
  def change
    create_table :tiles do |t|
      t.belongs_to :project
      t.text :image_data
      t.timestamps
    end
  end
end
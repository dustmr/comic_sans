class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      # t.belongs_to :user
      # t.belongs_to :project
      t.integer :number_rating
    end
  end
end
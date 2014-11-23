class AddColumnTiles < ActiveRecord::Migration
  def change
    add_column :tiles, :user_id, :integer ##Forgot to add user_id to tiles. Oops.
  end                                                       
end
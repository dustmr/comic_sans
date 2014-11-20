class AddColumnProjects < ActiveRecord::Migration
  def change
    add_column :projects do |t|
      t.string :completed
    end
  end
end
class AddColumnProjects < ActiveRecord::Migration
  def change
    add_column :projects do |t|
      t.boolean :completed, default: :false ##I want it so that we can track completed or in-progress based on a binary
    end                             ##figure we can set it as default 0 and then when projects completed somehow
  end                               ##toggle to 1. - JI
end
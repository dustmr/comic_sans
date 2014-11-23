class	AddLengthToStory  < ActiveRecord::Migration
	def change
		add_column :projects, :length, :integer
	end
end

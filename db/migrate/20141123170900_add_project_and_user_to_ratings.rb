class AddProjectAndUserToRatings < ActiveRecord::Migration
	def change
		add_column :ratings, :user_id, :integer
		add_column :ratings, :project_id, :integer
	end
end

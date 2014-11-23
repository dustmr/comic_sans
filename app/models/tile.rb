class Tile < ActiveRecord::Base
	belongs_to :user
	belongs_to :project

	default_scope order('created_at ASC')

	validates :project, presence: true

	after_save :check_tile_count

	def check_tile_count
		if project.tiles.count == project.length
			project.completed = true
			project.save
		end
	end
end

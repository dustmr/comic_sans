class Tile < ActiveRecord::Base
	belongs_to :user
	belongs_to :project


	validates :project, presence: true

	after_save :check_tile_count

	def check_tile_count
		if project.persisted? && project.tiles.count == project.length
			project.completed = true
			project.save
		end
	end
end

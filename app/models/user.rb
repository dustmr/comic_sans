class User < ActiveRecord::Base
	has_many :tiles
	has_many :ratings
	has_many :rated_projects, through: :ratings, source: :project
	has_many :comments

	validates :username, presence: true
end

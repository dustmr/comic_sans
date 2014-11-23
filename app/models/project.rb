class Project < ActiveRecord::Base
	has_many :tiles
	has_many :ratings
	# has_many :users, through: :ratings
	# has_one :rating
	validates :length, length: { maximum: 9 }, numericality: true


end

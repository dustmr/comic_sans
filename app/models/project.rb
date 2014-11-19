class Project < ActiveRecord::Base
  has_many :tiles
  has_many :ratings
  has_many :users, through: :ratings

end
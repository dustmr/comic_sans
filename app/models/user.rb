class User < ActiveRecord::Base
  has_many :tiles
  # has_many :projects
  # has_many :ratings

  validates :username, presence: true
end
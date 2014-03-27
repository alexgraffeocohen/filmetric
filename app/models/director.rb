class Director < ActiveRecord::Base
  has_many :director_movies
  has_many :movies, :through => :director_movies
end

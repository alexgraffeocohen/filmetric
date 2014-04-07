class Director < ActiveRecord::Base
  has_many :director_movies
  has_many :movies, :through => :director_movies

  include ApplicationHelper

  before_save :calculate_filmetric
end

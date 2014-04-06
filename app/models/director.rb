class Director < ActiveRecord::Base
  has_many :director_movies
  has_many :movies, :through => :director_movies

  def self.recalculate_filmetric_for(director)
    total = 0
    director.movies.each do |movie|
      total += (movie.critics_score - movie.audience_score)
    end
    director.filmetric = (total / director.movies.count)
    director.save
  end
end

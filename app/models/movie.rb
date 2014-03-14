class Movie < ActiveRecord::Base
  has_many :genre_movies
  has_many :actor_movies
  has_many :director_movies
  has_many :genres, :through => :genre_movies 
  has_many :actors, :through => :actor_movies
  has_many :directors, :through => :director_movies

  def Movie.generate_filmetrics
    Movie.all.each do |movie|
      movie.filmetric = (movie.critics_score - movie.audience_score)
      movie.save
    end
  end

  def calculate_filmetric
    filmetric = critics_score - audience_score
  end
end

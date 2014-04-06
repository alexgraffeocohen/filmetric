class Genre < ActiveRecord::Base
  has_many :genre_movies
  has_many :movies, :through => :genre_movies

  def self.recalculate_filmetric_for(genre)
    total = 0
    genre.movies.each do |movie|
      total += (movie.critics_score - movie.audience_score)
    end
    genre.filmetric = (total / genre.movies.count)
    genre.save
  end 
end

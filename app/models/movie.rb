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

  def actor_names=(actor_names)
    actor_names.each do |name|
      actor = Actor.find_or_create_by(name: name)
      self.actor_movies.build(actor: actor)
    end
  end

  def director_names=(director_names)
    director_names.each do |name|
      director = Director.find_or_create_by(name: name)
      self.director_movies.build(director: director)
    end
  end

  def genre_names=(genre_names)
    genre_names.each do |name|
      genre = Genre.find_or_create_by(name: name)
      self.genre_movies.build(genre: genre)
    end
  end
end

class Movie < ActiveRecord::Base
  has_many :genre_movies
  has_many :actor_movies
  has_many :director_movies
  has_many :genres, :through => :genre_movies 
  has_many :actors, :through => :actor_movies
  has_many :directors, :through => :director_movies

  before_destroy :break_ties

  def break_ties
    self.actors.each do |actor|
      relation = ActorMovie.find_by(actor: actor, movie: self)
      relation.destroy
      actor.destroy if actor.movies.empty?
      actor.save
    end

    self.genres.each do |genre|
      relation = GenreMovie.find_by(genre: genre, movie: self)
      relation.destroy
      genre.destroy if genre.movies.empty?
      genre.save
    end

    self.directors.each do |director|
      relation = DirectorMovie.find_by(director: director, movie: self)
      relation.destroy 
      director.destroy if director.movies.empty?
      director.save
    end
  end

  # def self.remove_tie_between(staff, movie)
  #   movie.staff.each do |staff|
  #     relation = ActorMovie.find_by(actor: actor, movie: movie)
  #     relation.destroy
  #     actor.destroy if actor.movies.empty?
  #     actor.save
  #   end
  # end

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

  def self.replace_release_years
    Movie.all.each do |movie|
      begin
        fetched_movie = RTQuerier.find_by_imdb_id(movie.id)
        movie.update(release_date: fetched_movie.release_dates.theater)
        puts "Updated #{movie.title} with #{movie.release_date}"
      rescue
        next
      end
    sleep 1
    end
  end
end

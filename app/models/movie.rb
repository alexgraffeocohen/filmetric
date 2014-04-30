class Movie < ActiveRecord::Base
  has_many :genre_movies
  has_many :actor_movies
  has_many :director_movies
  has_many :genres, :through => :genre_movies 
  has_many :actors, :through => :actor_movies
  has_many :directors, :through => :director_movies

  before_destroy :break_ties

  def break_ties
    remove_ties_with("actors")
    remove_ties_with("genres")
    remove_ties_with("directors")
  end

  def remove_ties_with(units)
   self.send(units).each do |unit|
      relation = "#{unit.class}Movie".constantize.find_by("#{unit.class}".downcase.to_sym => unit, movie: self)
      relation.destroy
      unit.destroy if unit.movies.empty?
      unit.save
    end
  end

  def assign(names, category)
    names.each do |name|
      object = category.capitalize.constantize.find_or_create_by(name: name)
      self.send("#{category}_movies").build("#{category}".to_sym => object)
    end
  end

  def release_year
    self.release_date.strftime("%Y") unless self.release_date.nil?
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
    sleep 0.25
    end
  end
end

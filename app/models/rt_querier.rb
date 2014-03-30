class RTQuerier
  attr_accessor :data
  include RottenTomatoes
  Rotten.api_key = ENV["RT_KEY"]

  def self.find_by_imdb_id(imdb_id)
    RottenMovie.find(:imdb => imdb_id)
  end

  def self.find_by_title(title)
    RottenMovie.find(:title => title)
  end

  def self.save_to_db(m)
    attributes = {
      :id => m.alternate_ids["imdb"],
      :title => m.title,
      :release_date => m.release_dates.theater,
      :critics_score => m.ratings.critics_score, 
      :audience_score => m.ratings.audience_score,
      :critics_consensus => m.critics_consensus,
      :genre_names => m.genres,
      :director_names => RTQuerier.parse_director_names(m.abridged_directors),
      :actor_names => RTQuerier.parse_actor_names(m.abridged_cast),
      :poster_link => m.posters["original"],
      :rating => m.mpaa_rating,
      :rt_link => m.links["alternate"]
    }

    Movie.create(attributes)
    puts "Stored #{m.title}"
  end

  def self.parse_director_names(directors)
    directors.map do |director|
      director.name
    end
  end

  def self.parse_actor_names(actors)
    actors.map do |actor|
      actor.name
    end
  end

  def self.parse_director_names(directors)
    directors.map do |director|
      director.name
    end
  end

  def initialize(data)
    self.data = data
    @count = 0
  end

  def query
    data.each do |e|
      begin
        next if !Movie.find(e).nil?
        movie = self.class.find_movie_by_imdb(e)
        next if movie.title.nil? || m.ratings.critics_score != -1
        make_movie_instance(movie)
        sleep 1
      rescue
        next
      end
    end 
  end

end
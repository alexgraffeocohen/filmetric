class RTQuerier
  attr_accessor :data
  include RottenTomatoes
  Rotten.api_key = ENV["RT_KEY"]

  def self.find_by_imdb_id(imdb_id)
    [RottenMovie.find(:imdb => imdb_id)]
  end

  def self.find_by_title(title)
    result = RottenMovie.find(:title => title)
    if result.is_a? Array
      result.map { |movie|
        begin
          self.find_by_imdb_id(movie.alternate_ids.imdb)
        rescue
          next
        end
      }.compact.flatten(1)
    else
      [self.find_by_imdb_id(result.alternate_ids.imdb)].flatten(1) unless result.alternate_ids.nil?
    end
  end

  def self.save_to_db(movie_list)
    movie_list.each do |m|
      next if m.title.nil? || m.ratings.critics_score == -1
      attributes = attributes_from_rt(m)
      director_names = RTQuerier.parse_director_names(m.abridged_directors)
      actor_names = RTQuerier.parse_actor_names(m.abridged_cast)
      genre_names = m.genres
      unless Movie.find_by(id: attributes[:id])
        movie = Movie.new(attributes)
        self.assign_data_for(movie, director_names, actor_names, genre_names)
      end
    end
  end

  def initialize(data)
    self.data = data
    @count = 0
  end

  def query
    data.each do |e|
      begin
        next if !Movie.find_by(id: e).nil?
        movie = self.class.find_by_imdb_id(e).first
        self.class.save_to_db([movie])
        sleep 0.25
      rescue
        next
      end
    end 
  end

  private

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

  def self.attributes_from_rt(m)
    {
      :id => m.alternate_ids["imdb"],
      :title => m.title,
      :release_date => m.release_dates.theater,
      :critics_score => m.ratings.critics_score, 
      :audience_score => m.ratings.audience_score,
      :filmetric => m.ratings.critics_score - m.ratings.audience_score,
      :critics_consensus => m.critics_consensus,
      :poster_link => m.posters["original"],
      :rating => m.mpaa_rating,
      :rt_link => m.links["alternate"]
    }
  end

  def self.assign_data_for(movie, director_names, actor_names, genre_names)
    movie.assign(director_names, "director")
    movie.assign(actor_names, "actor")
    movie.assign(genre_names, "genre")
    movie.save
  end
end
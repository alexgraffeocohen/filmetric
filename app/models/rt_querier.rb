class RTQuerier
  attr_accessor :data
  include RottenTomatoes
  Rotten.api_key = ENV["RT_KEY"]

  def self.find_movie_by_imdb(imdb_id)
    RottenMovie.find(:imdb => imdb_id)
  end

  def self.find_movie_by_name(title)
    RottenMovie.find(:title => title)
  end

  def initialize(data)
    self.data = data
    @count = 0
  end

  def make_movie_instance(m)
    attributes = {
      :title => m.title,
      :release_year => m.year,
      :critics_score => m.ratings.critics_score, 
      :audience_score => m.ratings.audience_score,
      :critics_consensus => m.critics_consensus,
      :genre1 => m.genres[0],
      :genre2 => m.genres[1],
      :genre3 => m.genres[2],
      :genre4 => m.genres[3],
      :genre5 => m.genres[4],
      :poster_link => m.posters["original"],
      :rating => m.mpaa_rating,
      :imdb_id => m.alternate_ids["imdb"],
      :rt_link => m.links["alternate"]
    }

    actors = []
    if m.abridged_cast.is_a? Array
      m.abridged_cast.each_with_index do |c, i|
        actors[i] = c["name"]
      end

      actors.each_with_index do |a, i|
        attributes["actor#{i+1}".to_sym] = a
      end
    end
    

    directors = []
    if m.abridged_directors.is_a? Array
      m.abridged_directors.each_with_index do |d, i|
        directors[i] = d["name"]
      end

      directors.each_with_index do |d, i|
        attributes["director#{i+1}".to_sym] = d
      end
    end

    if m.ratings.critics_score != -1
      Movie.create(attributes) unless 
      puts "Stored #{m.title}"
      @count += 1
    else
      puts "Skipped #{m.title}"
    end
  end
      
  def query
    data.each do |e|
      begin
      if e.to_i > 0
        next if !Movie.find(e).nil?
        movie = self.class.find_movie_by_imdb(e)
      end
        make_movie_instance(movie) unless movie.title.nil?
        sleep 1
      rescue
        next
      end
    end
    puts "#{@count} movies were saved." 
  end


end
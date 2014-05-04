module MoviesHelper

  def filmetric_responses 
    {
      (25..100) => "and critics are a little...too into it!",
      (16..25) => "and critics liked it a lot more!",
      (9..15) => "and critics liked it more.",
      (4..8) => "and critics liked it a little more.",
      (-3..3) => "and everyone likes it equally.",
      (-8..-4) => "and audiences liked it a little more.",
      (-15..-9) => "and audiences liked it more.",
      (-25..-16) => "and audiences liked it a lot more!",
      (-100..-25) => "and audiences are a little...too into it!"
    }
  end

  def parse_for_browsing(response_hash)
    array = []
    response_hash.values.each_with_index do |response, i|
       array << [i, strip(response)]
    end
    array
  end

  def strip(phrase)
    phrase.gsub('...', ' ').gsub(/!|\./, '').gsub('and ', '').gsub(' it', '')
  end

  def retrieve_range_for(choice)
    range = nil
    filmetric_responses.keys.each_with_index do |key, i|
      range = key if i == choice
    end 
    range
  end

  def quality_of(movie)
    average = (movie.critics_score + movie.audience_score)/2
    if average > 75
      "good"
    elsif average.between?(50,75)
      "ok"
    elsif average < 50
      "bad"
    end
  end

  def build_overview(movie)
    average = (movie.critics_score + movie.audience_score)/2

    if average > 88
      quality_response = "It’s amazing, "
    elsif average > 75
      quality_response = "It’s damn good, "
    elsif average.between?(50,75)
      quality_response = "It’s decent, "
    elsif average.between?(30,49)
      quality_response = "It’s kind of crap, "
    elsif average.between?(0,29)
      quality_response = "It’s probably crap, "
    end

    filmetric_response = ""

    filmetric_responses.each do |range, phrase|
      if range.include?(movie.filmetric)
        filmetric_response = phrase
      end
    end
    
    quality_response + filmetric_response
  end
end

module MoviesHelper

  def quality_of(movie)
    average = (movie.critics_score + movie.audience_score)/2
    if average > 88
      "good"
    elsif average > 75
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
    elsif average < 50
      quality_response = "It’s kind of crap, "
    elsif average < 30
      quality_response = "It's crap, "
    end

    filmetric_responses = {
    (16..25) => "and critics liked it a lot more!",
    (9..15) => "and critics liked it more.",
    (4..8) => "and critics liked it a litte more.",
    (-3..3) => "and everyone agrees.",
    (-8..-4) => "and audiences liked it a little more.",
    (-15..-9) => "and audiences liked it more.",
    (-30..-15) => "and critics liked it a lot more!",
    }

    if movie.filmetric > 25
      filmetric_response = "and critics are a little...too into it!"
    elsif movie.filmetric < -30
      filmetric_response = "and audiences are a little...too into it!"
    else
      filmetric_responses.each do |range, phrase|
        if range.include?(movie.filmetric)
          filmetric_response = phrase
        end
      end
    end

    quality_response + filmetric_response
  end
end

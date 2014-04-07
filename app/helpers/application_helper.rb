module ApplicationHelper

  def flash_class(level)
    case level
      when :notice then "alert alert-info alert-dismissable"
      when :success then "alert alert-success alert-dismissable"
      when :warning then "alert alert-warning alert-dismissable"
      when :alert then "alert alert-danger alert-dismissable"
    end
  end

  def calculate_filmetric
    total = 0
    movies.each do |movie|
      total += (movie.critics_score - movie.audience_score)
    end
    self.filmetric = (total / movies.length) unless self.movies.empty?
  end

end

class Actor < ActiveRecord::Base
  has_many :actor_movies
  has_many :movies, :through => :actor_movies

  def self.recalculate_filmetric_for(actor)
    total = 0
    actor.movies.each do |movie|
      total += (movie.critics_score - movie.audience_score)
    end
    actor.filmetric = (total / actor.movies.count)
    actor.save
  end

end

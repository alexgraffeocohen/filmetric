class MoviesController < ApplicationController

  def show
    @movie = Movie.find(params[:id])
    @average = (@movie.critics_score + @movie.audience_score)/2
  end

end

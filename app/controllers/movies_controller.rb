class MoviesController < ApplicationController

  def show
    @movie = Movie.find(params[:id])
    # @release = Date.parse(@movie.release_date).strftime("%B %-e, %Y")
  end

end

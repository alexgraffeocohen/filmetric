class MoviesController < ApplicationController

  def show
    @movie = Movie.find(params[:id])
    @release = @movie.release_date.strftime("%B %-e, %Y")
  end

  def browse
    @genres = Genre.all.select { |genre| genre.movies.length >= 20 }
  end

end

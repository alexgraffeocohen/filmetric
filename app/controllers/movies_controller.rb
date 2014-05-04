class MoviesController < ApplicationController
  include MoviesHelper

  def show
    @movie = Movie.find(params[:id])
    @release = @movie.release_date.strftime("%B %-e, %Y")
  end

  def browse
    binding.pry
    @filmetric_evals = parse_for_browsing(filmetric_responses)
    @genres = Genre.all.select { |genre| genre.movies.length >= 20 }
  end

end

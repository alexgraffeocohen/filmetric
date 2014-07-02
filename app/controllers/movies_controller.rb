class MoviesController < ApplicationController
  include MoviesHelper

  def show
    @movie = Movie.find(params[:id])
    @release = @movie.release_date.strftime("%B %-e, %Y")
    respond_to do |f|
      f.html { render 'show' }
      f.json { render json: @movie, status: 200 }
    end
  end

  def browse
    @filmetric_evals = options_for_browsing
    @genres = Genre.all.select { |genre| genre.movies.length >= 20 }
  end

  def discover
    range = retrieve_range_for(params["filmetric_eval"].to_i)
    genre = Genre.find(params["genre"].to_i)
    @choices = find_choices_for(range, genre)
  end

end

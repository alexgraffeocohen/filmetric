class GenresController < ApplicationController
  def show
    @genre = Genre.find(params[:id])
    @movies = @genre.movies.order("release_date asc")
  end
end

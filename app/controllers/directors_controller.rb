class DirectorsController < ApplicationController
  def show
    @director = Director.find(params[:id])
    @movies = @director.movies.order("release_date asc")
  end
end

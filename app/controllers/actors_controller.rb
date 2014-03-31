class ActorsController < ApplicationController

  def show
    @actor = Actor.find(params[:id])
    @movies = @actor.movies.order("release_date asc")
  end

end

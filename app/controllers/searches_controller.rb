require 'pry'

class SearchesController < ApplicationController

  def search
  end

  def show
    if params[:q].empty?
      flash.now[:notice] = "You gotta give me something! : )"
      render "search"
    end

    query = params[:q].split.collect(&:downcase).join(" ")

    case params[:category]
      when "Movie"
        @results = Movie.where('lower(title) LIKE ?', "%#{query}%")
        redirect_to movie_path(@results.first) if @results.count == 1
      when "Actor"
        @results = Actor.where('lower(name) LIKE ?', "%#{query}%")
        redirect_to actor_path(@results.first) if @results.count == 1
      when "Director"
        @results = Director.where('lower(name) LIKE ?', "%#{query}%")
        redirect_to director_path(@results.first) if @results.count == 1
      when "Genre"
        @results = Genre.where('lower(name) LIKE ?', "%#{query}%")
        redirect_to genre_path(@results.first) if @results.count == 1
    end
    
    if @results.empty?
      flash.now[:notice] = "I'm sorry, nothing matched what you were looking for."
      render "search" 
    end
  end

end

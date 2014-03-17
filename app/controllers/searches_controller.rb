class SearchesController < ApplicationController

  def search
  end

  def show
    case params[:category]
      when "Movie"
        @results = Movie.where('title LIKE ?', "%#{params[:q]}%")
      when "Actor"
        @results = Actor.where('name LIKE ?', "%#{params[:q]}%")
      when "Director"
        @results = Director.where('name LIKE ?', "%#{params[:q]}%")
      when "Genre"
        @results = Genre.where('name LIKE ?', "%#{params[:q]}%")
    end
  end

end

class SearchesController < ApplicationController

  def search
  end

  def show
    if params[:q].empty?
      flash.now[:notice] = "You gotta give me something! : )"
      render "search"
    end
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
    if @results.empty?
      flash.now[:notice] = "I'm sorry, nothing matched what you were looking for."
      render "search" 
    end
  end

end

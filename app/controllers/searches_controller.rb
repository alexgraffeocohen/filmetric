class SearchesController < ApplicationController

  def search
  end

  def show
    @results = Movie.where('title LIKE ?', "%#{params[:q]}%")
  end

end

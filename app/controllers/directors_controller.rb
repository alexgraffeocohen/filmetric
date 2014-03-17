class DirectorsController < ApplicationController
  def show
    @director = Director.find(params[:id])
  end
end

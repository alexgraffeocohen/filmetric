FilmetricRails::Application.routes.draw do
  root 'searches#search'
  get "/about" => 'static#about', as: 'about'

  get '/search' => 'searches#search'
  get '/searches/' => 'searches#show', as: 'searches'

  get '/movies/browse' => 'movies#browse', as: 'browse'
  get '/movies/discover' => 'movies#discover', as: 'discover'
  get '/movies/:id' => 'movies#show', as: 'movie'


  get '/actors/:id' => 'actors#show', as: 'actor'
  get '/directors/:id' => 'directors#show', as: 'director'
  get '/genres/:id' => 'genres#show', as: 'genre'
end
require 'spec_helper'

describe SearchesController do
  describe "GET #search" do
    it 'responds with a 200 status code' do
      get :search
      expect(response).to be_a_success
    end
  end

  describe "GET #show" do
    before(:each) do
      @die_hard = create(:movie, title: "Die Hard")
      @die_hard2 = create(:movie, title: "Die Hard 2")
      @gravity = create(:movie, title: "Gravity")
      @gravity2 = create(:movie, title: "Gravity 2")
      @movie = create(:movie)
      @owen = create(:actor, name: "Owen Wilson")
      @luke = create(:actor, name: "Luke Wilson")
      @bruce = create(:actor, name: "Bruce Willis")
      @actor = create(:actor)
      @alfonso = create(:director, name: "Alfonso Cuaron")
      @carlos = create(:director, name: "Carlos Cuaron")
      @director = create(:director)
      @genre = create(:genre)
      @die_hard.actors << @bruce
      @gravity.directors << @alfonso
    end

    it 'processes movie search with multiple results' do
      get :show, { q: 'die hard', category: 'Movie' }
      expect(response).to be_a_success
    end

    it 'redirects to movie when there is one result' do
      get :show, { q: @movie.title, category: 'Movie' }
      expect(response).to be_a_redirect
    end

    it 'redirects to movie where there is one result because actor was specified' do
      get :show, { q: 'die hard', category: 'Movie', actor: 'Bruce Willis' }
      expect(response).to be_a_redirect
    end

    it 'redirects to movie where there is one result because director was specified' do
      get :show, { q: 'gravity', category: 'Movie', director: 'Alfonso Cuaron' }
      expect(response).to be_a_redirect
    end

    it 'redirects to movie when found on RT' do
      get :show, { q: 'the iron giant', category: 'Movie' }
      expect(response).to be_a_redirect
    end

    it 're-renders search view when there is a bad result from RT' do
      get :show, { q: 'like stars on earth', category: 'Movie' }
      expect(response).to render_template('searches/search')
    end

    it 're-renders search view when nothing is provided for search' do
      get :show, { q: '', category: 'Movie' }
      expect(response).to render_template('searches/search')
    end

    it 're-renders search view when query isn\'t found' do
      get :show, {q: 'sugar plum princess', category: 'Movie' }
      expect(response).to render_template('searches/search')
    end

    it 'processes actor search with multiple results' do
      get :show, { q: 'wilson', category: 'Actor' }
      expect(response).to be_a_success
    end

    it 'redirects to actor when one result' do
      get :show, { q: @actor.name, category: 'Actor' }
      expect(response).to be_a_redirect
    end

    it 'processes director search with multiple results' do
      get :show, { q: 'cuaron', category: 'Director' }
      expect(response).to be_a_success
    end

    it 'redirects to director when one result' do
      get :show, { q: @director.name, category: 'Director' }
      expect(response).to be_a_redirect
    end

    it 'redirects to genre when one result' do
      get :show, { q: @genre.name, category: 'Genre' }
      expect(response).to be_a_redirect
    end
  end
end 

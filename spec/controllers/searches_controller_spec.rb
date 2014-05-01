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
      @movie = create(:movie)
      @owen = create(:actor, name: "Owen Wilson")
      @luke = create(:actor, name: "Luke Wilson")
      @actor = create(:actor)
      @alfonso = create(:director, name: "Alfonso Cuaron")
      @carlos = create(:director, name: "Carlos Cuaron")
      @director = create(:director)
      @genre = create(:genre)
    end

    it 'processes movie search with multiple results' do
      get :show, { q: 'die hard', category: 'Movie' }
      expect(response).to be_a_success
    end

    it 'redirects to movie when one result' do
      get :show, { q: @movie.title, category: 'Movie' }
      expect(response).to be_a_redirect
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

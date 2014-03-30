require 'spec_helper'

describe 'executing a movie search' do 
  before do
    Movie.create({
                   :id => 1454468,
                :title => "Gravity",
         :release_year => 2013,
        :critics_score => 97,
       :audience_score => 84,
    :critics_consensus => "Alfonso Cuaron's Gravity is an eerie, tense sci-fi thriller that's masterfully directed and visually stunning.",
          :poster_link => "http://content8.flixster.com/movie/11/17/64/11176450_ori.jpg",
               :rating => "PG-13",
              :rt_link => "http://www.rottentomatoes.com/m/gravity_2013/",
            :filmetric => 13
    })
  end

  context 'on the search page' do
    before do 
      visit search_path
    end

    it 'should have a search form' do
      expect(page).to have_css('form')
    end
    
    it 'should execute a new search' do
      select('Movie', :from => 'category')
      fill_in 'q', with: 'Gravity'
      click_button('Search')

      expect(page).to have_content("Gravity")
    end
  end
end 

describe 'executing an actor search' do
  before do
    Actor.create(name: "Brad Pitt", filmetric: -5)
  end

  context 'on the search page' do
    before do
      visit search_path
    end

    it 'should correctly find an actor' do
      select('Actor', :from => 'category')
      fill_in 'q', with: 'Brad'
      click_button('Search')

      expect(page).to have_content("Brad Pitt")
    end
  end
end

describe 'executing a director search' do
  before do
    Director.create(name: "Michael Bay", filmetric: -28)
  end

  context 'on the search page' do
    before do
      visit search_path
    end

    it 'should correctly find an actor' do
      select('Director', :from => 'category')
      fill_in 'q', with: 'Michael Bay'
      click_button('Search')

      expect(page).to have_content("Michael Bay")
    end
  end
end

describe 'executing a genre search' do
  before do
    Genre.create(name: "Action", filmetric: -5)
  end

  context 'on the search page' do
    before do
      visit search_path
    end

    it 'should correctly find an actor' do
      select('Genre', :from => 'category')
      fill_in 'q', with: 'Action'
      click_button('Search')

      expect(page).to have_content("Action")
    end
  end
end

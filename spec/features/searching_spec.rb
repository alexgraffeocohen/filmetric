require 'spec_helper'

describe 'executing a search' do 
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
      fill_in 'q', with: 'Gravity'
      click_button('Search')

      expect(page).to have_content("Gravity")
    end
  end
end

require 'spec_helper'

feature 'Search' do
  before(:each) do
    Movie.create(
                   :id => 1798709,
                :title => "Her",
         :release_date => "Fri, 10 Jan 2014",
        :critics_score => 94,
       :audience_score => 85,
    :critics_consensus => "Sweet, soulful, and smart, Spike Jonze's Her uses its just-barely-sci-fi scenario to impart wryly funny wisdom about the state of modern human relationships.",
          :poster_link => "http://content9.flixster.com/movie/11/17/28/11172839_ori.jpg",
               :rating => "R",
              :rt_link => "http://www.rottentomatoes.com/m/her/",
            :filmetric => 9
    )

    Movie.create(
                   :id => 1454468,
                :title => "Gravity",
         :release_date => "Fri, 04 Oct 2013",
        :critics_score => 97,
       :audience_score => 84,
    :critics_consensus => "Alfonso Cuaron's Gravity is an eerie, tense sci-fi thriller that's masterfully directed and visually stunning.",
          :poster_link => "http://content8.flixster.com/movie/11/17/64/11176450_ori.jpg",
               :rating => "PG-13",
              :rt_link => "http://www.rottentomatoes.com/m/gravity_2013/",
            :filmetric => 13
    )

    Movie.create(
                   :id => 206634,
                :title => "Children of Men",
         :release_date => "Mon, 25 Dec 2006",
        :critics_score => 93,
       :audience_score => 84,
    :critics_consensus => "Children of Men works on every level: as a violent chase thriller, a fantastical cautionary tale, and a sophisticated human drama about societies struggling to live. This taut and thought-provoking tale may not have the showy special effects normally found in movies of this genre, but you won't care one bit after the story kicks in, about a dystopic future where women can no longer conceive and hope lies within one woman who holds the key to humanity's survival. It will have you riveted.",
          :poster_link => "http://content6.flixster.com/movie/27/04/67/2704676_ori.jpg",
               :rating => "R",
              :rt_link => "http://www.rottentomatoes.com/m/children_of_men/",
            :filmetric => 9
      )
    Movie.create(
                   :id => 95016,
                :title => "Die Hard",
         :release_date => "Fri, 15 Jul 1988",
        :critics_score => 92,
       :audience_score => 94,
    :critics_consensus => "Its many imitators (and sequels) have never come close to matching the taut thrills of the definitive holiday action classic.",
          :poster_link => "http://content6.flixster.com/movie/11/16/47/11164776_ori.jpg",
               :rating => "R",
              :rt_link => "http://www.rottentomatoes.com/m/die_hard/",
            :filmetric => -2
      )
     Movie.create(
                   :id => 112864,
                :title => "Die Hard 3: With a Vengeance",
         :release_date => "Fri, 19 May 1995",
        :critics_score => 51,
       :audience_score => 84
      )
    Movie.create(
                   :id => 499549,
                :title => "Avatar",
         :release_date => "Fri, 18 Dec 2009",
        :critics_score => 83,
       :audience_score => 82,
    :critics_consensus => "It might be more impressive on a technical level than as a piece of storytelling, but Avatar reaffirms James Cameron's singular gift for imaginative, absorbing filmmaking.",
          :poster_link => "http://content7.flixster.com/movie/10/91/12/10911201_ori.jpg",
               :rating => "PG-13",
              :rt_link => "http://www.rottentomatoes.com/m/avatar/",
            :filmetric => 1
      )
    Movie.create(
                   :id => 87332,
                :title => "Ghostbusters",
         :release_date => "Fri, 01 Jun 1984",
        :critics_score => 96,
       :audience_score => 87,
    :critics_consensus => "An infectiously fun blend of special effects and comedy, with Bill Murray's hilarious deadpan performance leading a cast of great comic turns.",
          :poster_link => "http://content9.flixster.com/movie/11/16/74/11167403_ori.jpg",
               :rating => "PG",
              :rt_link => "http://www.rottentomatoes.com/m/ghostbusters/",
            :filmetric => 9
      )
    
    Actor.create(name: "Brad Pitt", filmetric: -5)
    Director.create(name: "Michael Bay", filmetric: -28)
    Genre.create(name: "Action", filmetric: -5)
  end

  scenario 'executing a movie search' do   
    visit search_path
    select('Movie', :from => 'category')
    fill_in 'q', with: 'Gravity'
    click_button('Search')

    expect(page).to have_content("Gravity")
  end

  scenario 'executing a movie search with multiple results' do
    visit search_path
    select('Movie', :from => 'category')
    fill_in 'q', with: 'Die Hard'
    click_button('Search')

    expect(page).to have_content("Die Hard")
    expect(page).to have_content("Die Hard 3: With a Vengeance")
  end

  scenario 'querying for movie not in database' do
    visit search_path
    select('Movie', :from => 'category')
    fill_in 'q', with: 'The Iron Giant'
    click_button('Search')

    expect(page).to have_content("The Iron Giant")
  end 
   
  scenario 'searching for an actor in database' do
    visit search_path
    select('Actor', :from => 'category')
    fill_in 'q', with: 'Brad'
    click_button('Search')

    expect(page).to have_content("Brad Pitt")
  end
    

  scenario 'searching for a director in database' do
    visit search_path
    select('Director', :from => 'category')
    fill_in 'q', with: 'Michael Bay'
    click_button('Search')

    expect(page).to have_content("Michael Bay")
  end
   

  scenario 'searching for a genre in database' do
    visit search_path
    select('Genre', :from => 'category')
    fill_in 'q', with: 'Action'
    click_button('Search')

    expect(page).to have_content("Action")
  end
end
   

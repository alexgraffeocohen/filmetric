require 'spec_helper'

feature 'Browsing' do
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

    gravity = Movie.create(
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
    GenreMovie.create(genre: Genre.create(name: "Action", filmetric: -5), movie: gravity)

    # let(:no_poster) { create(:movie, critics_score: 90, audience_score: 85, poster_link: "http://images.rottentomatoescdn.com/images/redesign/poster_default.gif") } 
    # let(:movie) { create(:movie, critics_score: 90, audience_score: 85, poster_link: "http://content9.flixster.com/movie/28/67/286791_ori.jpg") } 
    # let(:genre) { Genre.create(name: "Action") }
    range = (4..15)
  end
 
    # 20.times do 
    #   genre.genre_movies.create(
    #     movie: create(:movie, 
    #       critics_score: 90, 
    #       audience_score: 85, 
    #       poster_link: "http://content9.flixster.com/movie/28/67/286791_ori.jpg")
    #     )
    # end

  xscenario 'displaying movies that match criteria', js: true do
    visit browse_path
    select('Action', from: 'genre')
    select('critics like more', from: 'filmetric_eval')
    click_button('Search')

    link = find(:css, 'div.choice a[href]')
    expect(link).to include(movie.id)
  end

end
require 'spec_helper'

describe Movie do
  let(:her) {
    Movie.create(
                   :id => 1798709,
                :title => "Her",
         :release_date => "2013",
        :critics_score => 94,
       :audience_score => 85,
    :critics_consensus => "Sweet, soulful, and smart, Spike Jonze's Her uses its just-barely-sci-fi scenario to impart wryly funny wisdom about the state of modern human relationships.",
          :poster_link => "http://content9.flixster.com/movie/11/17/28/11172839_ori.jpg",
               :rating => "R",
              :rt_link => "http://www.rottentomatoes.com/m/her/",
            :filmetric => 9
    )
  }
  let(:gravity) {
    Movie.create(
                   :id => 1454468,
                :title => "Gravity",
         :release_date => "2013",
        :critics_score => 97,
       :audience_score => 84,
    :critics_consensus => "Alfonso Cuaron's Gravity is an eerie, tense sci-fi thriller that's masterfully directed and visually stunning.",
          :poster_link => "http://content8.flixster.com/movie/11/17/64/11176450_ori.jpg",
               :rating => "PG-13",
              :rt_link => "http://www.rottentomatoes.com/m/gravity_2013/",
            :filmetric => 13
    )
  }

  it 'can remove a movie and update associated records' do
    peabody = Movie.create(
      :id => 864835,
      :title => "Mr. Peabody & Sherman",
      :release_date => "2014-03-07",
      :critics_score => 79,
      :audience_score => 79,
      :critics_consensus => "Mr. Peabody & Sherman offers a surprisingly entertaining burst of colorful all-ages fun, despite of its dated source material and rather convoluted plot.",
      :poster_link => "http://content9.flixster.com/movie/11/17/57/11175779_ori.jpg",
      :rating => "PG",
      :rt_link => "http://www.rottentomatoes.com/m/mr_peabody_and_sherman/",
      :filmetric => 0,
      :director_names => ["Rob Minkoff", "Michael Bay"],
      :actor_names => ["Ty Burrell", "Max Charles", "Stephen Colbert", "Allison Janney", "Ariel Winter"],
      :genre_names => ["Action & Adventure", "Animation", "Kids & Family", "Comedy"]
    )
    rob = Director.find_by(name: "Rob Minkoff")
    ty = Actor.find_by(name: "Ty Burrell")
    action = Genre.find_by(name: "Action & Adventure")

    rob.movies << gravity << her
    Director.recalculate_filmetric_for(rob)
    ty.movies << gravity << her
    Actor.recalculate_filmetric_for(ty)
    action.movies << gravity << her
    Genre.recalculate_filmetric_for(action)

    Movie.remove_movie(peabody)
    rob.reload
    ty.reload
    action.reload

    expect{Movie.find('864835')}.to raise_error

    expect(rob.movies.count).to eq(2)
    expect(rob.filmetric).to eq(11)
    expect(ty.movies.count).to eq(2)
    expect(ty.filmetric).to eq(11)
    expect(action.movies.count).to eq(2)
    expect(action.filmetric).to eq(11)

    expect(Director.find_by(name: "Michael Bay")).to eq(nil)
    expect(Actor.find_by(name: "Max Charles")).to eq(nil)
    expect(Genre.find_by(name: "Animation")).to eq(nil)
  end
end

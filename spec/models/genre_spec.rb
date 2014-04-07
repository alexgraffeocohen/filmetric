require 'spec_helper'

describe Genre do
  let(:action) {Genre.new(name: "Action")}
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

  it 'calculates filmetric on save' do
    action.movies << her << gravity
    action.save
    action.reload

    expect(action.filmetric).to eq(11)
  end
end
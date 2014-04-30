require 'spec_helper'

describe Movie do
  let(:rob) { Director.create(name: "Rob Minkoff") }
  let(:michael) { Director.create(name: "Michael Bay") }
  let(:ty)  { Actor.create(name: "Ty Burrell") }
  let(:max)  { Actor.create(name: "Max Charles") }
  let(:action) { Genre.create(name: "Action & Adventure") }
  let(:animation) { Genre.create(name: "Animation") }

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

  describe 'deleting a movie' do
    before(:each) do
      rob.movies << gravity << her
      rob.save
      ty.movies << gravity << her
      ty.save
      action.movies << gravity << her
      action.save

      peabody = Movie.new(
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
      )

      peabody.assign(["Rob Minkoff", "Michael Bay"], "director")
      peabody.assign(["Ty Burrell", "Max Charles"], "actor")
      peabody.assign(["Action & Adventure", "Animation"], "genre")
      peabody.save

      peabody.destroy
      rob.reload
      ty.reload
      action.reload
    end


    it 'can remove a movie' do 
      expect{Movie.find('864835')}.to raise_error
    end

    it 'can remove movie from actors and update their filmetrics' do
      expect(ty.movies.count).to eq(2)
      expect(ty.filmetric).to eq(11)
    end

    it 'can remove movie from directors and update filmetrics' do
      expect(rob.movies.count).to eq(2)
      expect(rob.filmetric).to eq(11)
    end

    it 'can remove movie from genres and update filmetrics' do
      expect(action.movies.count).to eq(2)
      expect(action.filmetric).to eq(11)
    end

    it 'can delete a director when he/she no longer has movies after deletion' do
      expect(Director.find_by(name: "Michael Bay")).to eq(nil)
    end

    it 'can delete an actor when he/she no longer has movies after deletion' do
      expect(Actor.find_by(name: "Max Charles")).to eq(nil)
    end
    
    it 'can delete a genre when it no longer has movies after deletion' do
      expect(Genre.find_by(name: "Animation")).to eq(nil)
    end
  end
end

require 'spec_helper'

describe MoviesHelper do
  let(:movie) { create(:movie, critics_score: 90, audience_score: 85, poster_link: "http://content9.flixster.com/movie/28/67/286791_ori.jpg") }
  let(:no_poster) { create(:movie, critics_score: 90, audience_score: 85, poster_link: "http://images.rottentomatoescdn.com/images/redesign/poster_default.gif") }
  let(:genre) { create(:genre) }

  it 'provides filmetric responses for browsing form' do
    expect(options_for_browsing).to eq([
     [0, "critics like a lot more"],
     [1, "critics like more"],
     [2, "critics and audiences like equally"],
     [3, "audiences like more"],
     [4, "audiences like a lot more"]
     ])
  end

  it 'can retrieve a range given a key of filmetric hash' do
    critics_more = 1
    equal = 2
    audience_more = 3

    expect(helper.retrieve_range_for(critics_more)).to eq((4..15))
    expect(helper.retrieve_range_for(equal)).to eq((-3..3))
    expect(helper.retrieve_range_for(audience_more)).to eq((-15..-4))
  end

  it 'can provide movies that match criteria' do
    movie.genres << genre
    range = (4..15)

    expect(helper.find_choices_for(range, genre)).to include(movie)
  end

  it 'can reject movies for browswing that don\'t have posters' do
    movie.genres << genre
    no_poster.genres << genre
    range = (4..15)

    expect(helper.find_choices_for(range, genre)).to_not include(no_poster)
  end
end
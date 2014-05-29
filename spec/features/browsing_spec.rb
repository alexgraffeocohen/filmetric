require 'spec_helper'

feature 'Browsing' do
  let(:movie) { create(:movie, critics_score: 90, audience_score: 85, poster_link: "http://content9.flixster.com/movie/28/67/286791_ori.jpg") }
  let(:no_poster) { create(:movie, critics_score: 90, audience_score: 85, poster_link: "http://images.rottentomatoescdn.com/images/redesign/poster_default.gif") }
  let(:genre) { create(:genre, name: "Action") }
  let(:range) { (4..15) }

  before(:each) do
    movie.genres << genre
    no_poster.genres << genre
  end

  scenario 'displaying movies that match criteria', js: true do
    visit browse_path
    binding.pry
    select('Action', from: 'genre')
    select('critics like more', from: 'filmetric_eval')
    click_button('Search')

    link = find(:css, 'div.choice a[href]')
    expect(link).to include(movie.id)
  end

end
require 'spec_helper'

feature 'Browsing' do

  scenario 'displaying movies that match criteria', js: true do
    action = create(:genre)

    20.times do
      action.movies << create(:movie_critics_like_more)
    end

    visit browse_path
    select('Action', from: 'genre')
    select('critics like more', from: 'filmetric_eval')
    click_button('Search')

    page.should have_selector("#movie-options")
    posters = page.all("#movie-options img")
    expect(posters.count).to eq 20
    expect(posters.first[:src]).to eq "http://content6.flixster.com/movie/11/16/80/11168096_ori.jpg"
  end

end

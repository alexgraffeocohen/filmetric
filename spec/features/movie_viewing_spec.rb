require 'spec_helper'

feature 'Viewing Movies' do
  before(:each) do
    @amazing_movie = create(:movie, critics_score: 95, audience_score: 90)
    @good_movie = create(:movie, critics_score: 85, audience_score: 80)
    @decent_movie = create(:movie, critics_score: 65, audience_score: 60)
    @bad_movie = create(:movie, critics_score: 45, audience_score: 40)
    @crappy_movie = create(:movie, critics_score: 20, audience_score: 15)
  end

  scenario 'viewing an amazing movie' do
    visit movie_path(@amazing_movie.id)

    expect(page).to have_content('It’s amazing')
  end

  scenario 'viewing an amazing movie' do
    visit movie_path(@good_movie.id)

    expect(page).to have_content('It’s damn good')
  end
end
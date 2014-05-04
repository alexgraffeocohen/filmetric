require 'spec_helper'

feature 'Viewing Movies' do
  describe 'Testing first part of response' do
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

    scenario 'viewing a good movie' do
      visit movie_path(@good_movie.id)

      expect(page).to have_content('It’s damn good')
    end

    scenario 'viewing a decent movie' do
      visit movie_path(@decent_movie.id)

      expect(page).to have_content('It’s decent')
    end

    scenario 'viewing a bad movie' do
      visit movie_path(@bad_movie.id)

      expect(page).to have_content('It’s kind of crap')
    end

    scenario 'viewing a crappy movie' do
      visit movie_path(@crappy_movie.id)

      expect(page).to have_content('It’s probably crap')
    end
  end

  describe 'testing second part of response' do
    before(:each) do
      @critics_too_into = create(:movie, critics_score: 100, audience_score: 70)
      @critics_like_a_lot_more = create(:movie, critics_score: 100, audience_score: 80)
      @critics_like_more = create(:movie, critics_score: 100, audience_score: 85)
      @critics_like_little_more = create(:movie, critics_score: 100, audience_score: 92)
      
      @everyone_agrees = create(:movie, critics_score: 100, audience_score: 98)

      @audiences_like_little_more = create(:movie, critics_score: 92, audience_score: 100)
      @audiences_like_more = create(:movie, critics_score: 85, audience_score: 100)
      @audiences_like_a_lot_more = create(:movie, critics_score: 80, audience_score: 100)
      @audiences_too_into = create(:movie, critics_score: 70, audience_score: 100)      
    end

    scenario 'viewing a movie critics are too into' do
      visit movie_path(@critics_too_into.id)

      expect(page).to have_content('and critics are a little...too into it!')
    end

    scenario 'viewing a movie critics like a lot more' do
      visit movie_path(@critics_like_a_lot_more.id)

      expect(page).to have_content('and critics liked it a lot more!')
    end

    scenario 'viewing a movie critics like more' do
      visit movie_path(@critics_like_more.id)

      expect(page).to have_content('and critics liked it more.')
    end

    scenario 'viewing a movie critics like a little more' do
      visit movie_path(@critics_like_little_more.id)

      expect(page).to have_content('and critics liked it a little more.')
    end

    scenario 'viewing a movie on which people agree' do
      visit movie_path(@everyone_agrees.id)

      expect(page).to have_content('and everyone likes it equally.')
    end

    scenario 'viewing a movie audiences like a little more' do
      visit movie_path(@audiences_like_little_more.id)

      expect(page).to have_content('and audiences liked it a little more.')
    end

    scenario 'viewing a movie audiences like more' do
      visit movie_path(@audiences_like_more.id)

      expect(page).to have_content('and audiences liked it more.')
    end

    scenario 'viewing a movie audiences like a lot more' do
      visit movie_path(@audiences_like_a_lot_more.id)

      expect(page).to have_content('and audiences liked it a lot more!')
    end

    scenario 'viewing a movie audiences are too into' do
      visit movie_path(@audiences_too_into.id)

      expect(page).to have_content('and audiences are a little...too into it!')
    end
  end
end
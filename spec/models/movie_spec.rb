require 'spec_helper'

describe Movie do
  let(:movie) { Movie.new }

  it 'has a title' do
    movie.title = "The Matrix"
    expect(movie.title).to eq("The Matrix")
  end

  it 'has a release year' do
    movie.release_year = 1999
    expect(movie.release_year).to eq(1999)
  end

  it 'has a critics score' do
    movie.critics_score = 65
    expect(movie.critics_score).to eq(65)
  end

  it 'has an audience score' do
    movie.audience_score = 85
    expect(movie.audience_score).to eq(85)
  end

  it 'can calculate its own filmetric' do
    movie.critics_score = 82
    movie.audience_score = 70

    expect(movie.calculate_filmetric).to eq(12)
  end
end

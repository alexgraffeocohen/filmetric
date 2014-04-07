require 'spec_helper'

describe RTQuerier do
  let(:ids) {['0892769', '1120985', '0840361']}
  let(:querier) {RTQuerier.new(ids)}
  let(:title) {"The Matrix"}
  
  it 'can take data on initialization' do
    expect(querier.data).to eq(ids)
  end

  it 'can find a movie by imdb id' do
    movie = RTQuerier.find_by_imdb_id('0892769')
    expect(movie.title).to_not eq(nil)
  end

  it 'can find a movie by name' do  
    movie_options = RTQuerier.find_by_title(title)
    expect(movie_options[0].title).to eq("The Matrix")
  end

  it 'can save a movie from search results' do
    results = RTQuerier.find_by_imdb_id('0892769')
    RTQuerier.save_to_db(results)
    saved_movie = Movie.first

    expect(saved_movie.title).to eq("How to Train Your Dragon")
    expect(saved_movie.actors).to include(Actor.find_by(name: "Jay Baruchel"))
    expect(saved_movie.directors).to include(Director.find_by(name: "Chris Sanders"))
    expect(saved_movie.genres).to include(Genre.find_by(name: "Kids & Family"))
  end

  it 'will not save non-matches by imdb_id to database' do
    bad_id = '9673657'
    expect{RTQuerier.new([bad_id]).query}.to_not change{Movie.count}.by(1)
  end

  it 'will not save movies already in database' do
    Movie.create(id: '0892769')  
    expect{RTQuerier.new([ids[0]]).query}.to_not change{Movie.count}.by(1)
  end

  it 'will not save movies that haven\'t been rated' do
    unrated_id = '986264'
    expect{RTQuerier.new([unrated_id]).query}.to_not change{Movie.count}.by(1)
  end
end
require 'spec_helper'

describe RTQuerier do
  let(:ids) {['0892769', '1120985', '0840361']}
  let(:querier) {RTQuerier.new(ids)}
  let(:title) {"The Matrix"}
  
  it 'takes data on initialization' do
    expect(querier.data).to eq(ids)
  end

  it 'can find a movie by imdb id' do
    movie = RTQuerier.find_movie_by_imdb(ids[0])
    expect(movie.title).to_not eq(nil)
  end

  it 'can find a movie by name' do
    movie_options = RTQuerier.find_movie_by_name(title)
    expect(movie_options[0].title).to eq("The Matrix")
  end

  it 'will not save non-matches by imdb id' do
    bad_id = '9673657584'
    expect{RTQuerier.new([bad_id]).query}.to_not change{Movie.count}.by(1)
  end

  it 'will not save movies already in db' do
    Movie.create(id: "#{ids[0]}")    
    expect{RTQuerier.new([ids[0]]).query}.to_not change{Movie.count}.by(1)
  end

  it 'will not save movies that haven\'t been rated' do
    unrated_id = '986264'
    expect{RTQuerier.new([unrated_id]).query}.to_not change{Movie.count}.by(1)
  end

  xit 'can identify an integer' do
    id = ['0892769']
    querier = RTQuerier.new(id)
    querier.query

    expect(id.to_i > 0).to be(true)
  end

  xit 'can identify a string' do
    title = ["The Matrix"]
    querier = RTQuerier.new(title)
    querier.query

    expect(title.to_i > 0).to be(false)
  end

  xit 'can find a movie by name' do
    title = "The Matrix"
    movie = querier.find_movie_by_name(title)

    expect(movie.title).to_not eq("The Matrix")
  end

  xit 'can create movie instances from RT queries' do
    querier.query

    expect(Movie.all.count).to eq(3)
  end

  xit 'can fill movie instances with valid data' do
  end

end
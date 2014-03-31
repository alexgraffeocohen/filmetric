require_relative 'spec_helper'

describe IMDBScraper do
  let(:url) {'http://www.imdb.com/search/title?at=0&groups=top_1000&sort=year,desc&view=simple'}

  it 'has titles' do
    scraper = IMDBScraper.new(url)
    expect(scraper.ids).to eq([])
  end

  it 'sets counter to 0 on initialization' do
    scraper = IMDBScraper.new(url)
    expect(scraper.counter).to eq(0)
  end

  it 'can query nokogiri' do
    scraper = IMDBScraper.new(url)
    scraper.nokogiri_query(url)
    expect(scraper.ids.length).to_not eq(0)
  end

  it 'can scrape a specific figure\'s movies' do
    url = IMDBScraper.find_page("Tom Cruise")
    scraper = IMDBScraper.new(url)
    scraper.scrape

    expect(scraper.ids).to include('0259711')
  end

  it 'can generate valid urls' do
    scraper = IMDBScraper.new(url)
    new_url = scraper.generate_url(5)
    scraper.nokogiri_query(new_url)
    expect(scraper.ids.length).to_not eq(0)
  end

  it 'gets titles while scraping' do
    scraper = IMDBScraper.new(url)
    scraper.scrape
    expect(scraper.ids.length).to_not eq(0)
  end
end 
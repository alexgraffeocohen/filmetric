require 'open-uri'

class IMDBScraper
  attr_accessor :ids, :counter, :base_url, :pages_to_scrape

  def initialize(base_url, pages_to_scrape)
    self.base_url = base_url
    self.ids = []
    self.counter = 0
    self.pages_to_scrape = pages_to_scrape
  end

  def nokogiri_query(url)
    Nokogiri::HTML(open(url)).css('table.results td.title a[href]').each do |m|
     ids << m.attributes["href"].value.scan(/\d/).join
    end
  end

  def generate_url(counter)
    if counter == 0
      base_url
    else
      new_url = "#{base_url}&start=#{counter}01"
      new_url
    end
  end

  def scrape
    while counter < pages_to_scrape
      nokogiri_query(generate_url(counter))
      self.counter += 1
    end
  end
end
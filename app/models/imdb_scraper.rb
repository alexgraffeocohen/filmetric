require 'open-uri'

class IMDBScraper
  attr_accessor :ids, :counter, :base_url, :pages_to_scrape

  def initialize(base_url, num_pages)
    self.base_url = base_url
    self.ids = []
    self.counter = 0
    self.pages_to_scrape = num_pages
  end

  def nokogiri_query(url)
    Nokogiri::HTML(open(url)).css(link_selector).each do |tag|
     ids << extract_id_from(tag)
    end
  end

  def generate_url(counter)
    counter == 0 ? base_url : url_for_next_result_page(base_url, counter)
  end

  def scrape
    while counter < pages_to_scrape
      nokogiri_query(generate_url(counter))
      self.counter += 1
    end
  end

  private

  def link_selector
    'table.results td.title a[href]'
  end

  def extract_id_from(tag)
    tag.attributes["href"].value.scan(/\d/).join
  end

  def url_for_next_result_page(base_url, counter)
    "#{base_url}&start=#{counter}01"
  end
end

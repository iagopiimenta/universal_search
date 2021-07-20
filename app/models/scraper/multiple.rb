# frozen_string_literal: true

require 'open-uri'

module Scraper
  class Multiple
    BASE_HOST = 'http://www.google.com/search'

    def search(query)
      google_results = Scraper::Google.new.search(query)
      bing_results = Scraper::Bing.new.search(query)

      google_results + bing_results
    end
  end
end

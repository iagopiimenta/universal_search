# frozen_string_literal: true

require 'open-uri'

module Scraper
  class Bing
    BASE_HOST = 'http://bing.com/search'

    attr_reader :browser, :driver

    def initialize
      @browser = Capybara.current_session
      @driver = @browser.driver.browser
    end

    def search(query)
      html = fetch_papge(query)

      html.css('#b_results > .b_algo').map do |entry|
        link = entry.css('h2 a').first
        next if link.nil?

        Record.new(
          title: entry.css('h2').text,
          description: entry.css('.b_caption p').text,
          link: link['href']
        )
      end.compact
    end

    private

    def fetch_papge(query)
      url = build_url_for(query)
      browser.visit(url)

      sleep(0.1) while driver.execute_script('return document.readyState') != 'complete'

      Nokogiri::HTML(driver.page_source)
    end

    def build_url_for(query)
      url = Addressable::URI.parse(BASE_HOST)
      url.query_values = { q: query }

      url
    end
  end
end

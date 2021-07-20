module Scraper
  class Record
    attr_reader :title, :description, :link

    def initialize(title:, description:, link:)
      @title = title
      @description = description
      @link = link
    end
  end
end

# frozen_string_literal: true

module Scraper
  class Record
    attr_reader :title, :description, :link, :engine

    def initialize(title:, description:, link:, engine:)
      @title = title
      @description = description
      @link = link
      @engine = engine
    end
  end
end

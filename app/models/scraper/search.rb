# frozen_string_literal: true

require 'open-uri'

module Scraper
  class Search
    ENGINES = {
      'google' => Scraper::Google,
      'bing' => Scraper::Bing,
      'both' => Scraper::Multiple
    }.freeze

    # TODO: use enumerator
    # TODO: add pagination
    # TODO: handle cota limit errors
    def search(engine_name, query)
      return [] if query.blank? || engine_name.blank?

      engine_class = build_engine_for(engine_name)
      engine_class.new.search(query)
    end

    private

    def build_engine_for(engine_name)
      ENGINES[engine_name] || ENGINES['google']
    end
  end
end

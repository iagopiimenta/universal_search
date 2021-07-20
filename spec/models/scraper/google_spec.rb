# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Scraper::Google do
  describe '#search' do
    vcr_options = { cassette_name: 'google_github_search_result' }
    it 'return a valid response', vcr: vcr_options do
      result = described_class.new.search('github')
      expect(result.size).to eq(97)
    end

    vcr_options = { cassette_name: 'google_github_search_result' }
    it 'return a valid record', vcr: vcr_options do
      result = described_class.new.search('github')
      record = result.first

      expect(record.title).to eq('GitHub')
      expect(record.link).to eq('https://github.com')
      expect(record.description).to include('GitHub is where over 65 million developers shape the')
    end
  end
end

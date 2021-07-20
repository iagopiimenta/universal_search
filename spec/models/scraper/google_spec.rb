require "rails_helper"

RSpec.describe Scraper::Google do
  describe "#search" do
    it "return a valid response", :vcr do
      result = described_class.new.search('github')
      expect(result.size).to eq(97)
    end
  end
end

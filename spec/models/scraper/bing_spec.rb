require "rails_helper"

RSpec.describe Scraper::Bing do
  describe "#search" do
    before do
      Capybara.default_driver = :selenium_chrome_headless_billy
      Capybara.javascript_driver = :selenium_chrome_headless_billy
    end

    it "return a valid response", :vcr do
      result = described_class.new.search('github')
      expect(result.size).to eq(10)
    end
  end
end

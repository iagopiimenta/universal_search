# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchesController do
  describe 'GET show' do
    it 'returns a 200' do
      get :show
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET show with query' do
    let(:search_results) { assigns(:search_results) }

    vcr_options = { cassette_name: 'both_github_search_result' }
    it 'returns a 200', vcr: vcr_options do
      get :show, params: { text: 'github', engine: 'both' }
      expect(response).to have_http_status(:ok)
    end

    it 'returns google results', vcr: vcr_options do
      get :show, params: { text: 'github', engine: 'both' }

      expect(search_results.select { |r| r.engine == Scraper::Google }.size).to eq(97)
    end

    it 'returns bing results', vcr: vcr_options do
      get :show, params: { text: 'github', engine: 'both' }

      expect(search_results.select { |r| r.engine == Scraper::Bing }.size).to eq(10)
    end
  end
end

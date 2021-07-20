# frozen_string_literal: true

class SearchesController < ApplicationController
  def show
    @search_results = Scraper::Search.new.search(params[:engine], params[:text])
  end
end

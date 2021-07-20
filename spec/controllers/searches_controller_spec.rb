# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchesController do
  describe 'GET index' do
    it 'returns a 200' do
      get :show
      expect(response).to have_http_status(:ok)
    end
  end
end

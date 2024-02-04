# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Movies', type: :request do
  describe 'GET /index' do
    before(:each) do
      get '/movies'
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the movie index template' do
      expect(response).to render_template(:index)
      expect(response.body).to include('Brave')
    end
  end

  describe 'utility methods' do
    it 'sorts movies by watched date' do
      result = MoviesController.sort([movies(:mandy), movies(:brave), movies(:hoop_dreams)])
      sorted_movies = [movies(:mandy), movies(:brave), movies(:hoop_dreams)]
      expect(result[0].title).to eq(sorted_movies[0].title)
      expect(result[1].title).to eq(sorted_movies[1].title)
      expect(result[2].title).to eq(sorted_movies[2].title)
    end
  end
end

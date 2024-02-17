# frozen_string_literal: true

require 'rails_helper'
require 'benchmark'

RSpec.describe 'Ratings', type: :request do
  let(:controller_instance) { RatingsController.new }
  describe 'GET /ratings' do
    context 'when request is successful' do
      it 'should respond with a 200 (OK)' do
        get '/ratings'
        expect(response).to have_http_status(200)
      end

      it 'should render the index template' do
        get '/ratings'
        expect(response).to render_template(:index)
      end

      it 'should render a sorted list of ratings' do
        get '/ratings'
        expect(response.body).to include('Rebecca')
      end
    end
  end

  describe 'POST /rating' do
    let(:user) { User.first }
    let(:movie) { Movie.first }
    let(:rating) { { user_id: user.id, movie_id: movie.id, score: 11, watched_date: '2024-02-02' } }
    context 'when rating is successfully recorded' do
      before do
        post add_rating_path, params: { rating: {user_id: rating[:user_id], movie_id: rating[:movie_id], score: rating[:score], watched_date: rating[:watched_date] }}
      end
      it 'shoud respond with a 302 (redirect)' do
        expect(response).to have_http_status(302)
      end
      # it 'should return the new rating id' do
      #   expect(JSON.parse(response.body)).to include({'id' => 2})
      # end
      it 'should flash with a sucess message' do
        expect(flash[:success]).not_to be_nil
      end

      it 'should render the ratings list, with the new rating included' do
        expect(response).to redirect_to(ratings_path)
      end
    end
  end
end

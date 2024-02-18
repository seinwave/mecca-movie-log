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
    context 'when successfully rating an existing movie' do
      let(:user) { User.first }
      let(:movie) { Movie.first }
      let(:valid_rating) { { user_id: user.id, movie_id: movie.id, score: 11, watched_date: Date.today } }
      it 'should create a new Rating' do
        expect do
          post add_rating_path, params: { rating: valid_rating }
        end.to change(Rating, :count).by(1)
      end
      it 'shoud respond with a 302 (redirect)' do
        post add_rating_path, params: { rating: valid_rating }
        expect(response).to have_http_status(302)
      end
      it 'should flash with a sucess message' do
        post add_rating_path, params: { rating: valid_rating }
        expect(flash[:success]).not_to be_nil
      end
      it 'should render the ratings list, with the new rating included' do
        post add_rating_path, params: { rating: valid_rating }
        expect(response).to redirect_to(ratings_path)
      end
    end
    context 'when successfully rating a new movie', :clean_db do
      let(:user) { FactoryBot.create(:user) }
      let(:rating_with_new_movie) do
        { user_id: user.id, movie_attributes: { title: 'Fronkie' }, score: 11, watched_date: Date.today }
      end
      it 'creates a new Movie' do
        expect do
          post add_rating_path, params: { rating: rating_with_new_movie }
        end.to change(Movie, :count).by(1)
      end
      it 'creates a new Rating' do
        expect do
          post add_rating_path, params: { rating: rating_with_new_movie }
        end.to change(Rating, :count).by(1)
      end
      it 'shoud respond with a 302 (redirect)' do
        post add_rating_path, params: { rating: rating_with_new_movie }
        expect(response).to have_http_status(302)
      end
      it 'should flash with a sucess message' do
        post add_rating_path, params: { rating: rating_with_new_movie }
        expect(flash[:success]).not_to be_nil
      end
      it 'should render the ratings list, with the new rating included' do
        post add_rating_path, params: { rating: rating_with_new_movie }
        expect(response).to redirect_to(ratings_path)
      end
    end
    context 'when posting a rating without a movie' do
      let(:user) { User.first }
      let(:movie) { Movie.first }
      let(:invalid_rating) { { user_id: user.id, score: 11, watched_date: Date.today } }
      it 'should not create a new Rating' do
        expect do
          post add_rating_path, params: { rating: invalid_rating }
        end.not_to change(Rating, :count)
      end
      it 'should not create a new Movie' do
        expect do
          post add_rating_path, params: { rating: invalid_rating }
        end.not_to change(Rating, :count)
      end
      it 'shoud respond with a 400 (bad request)' do
        post add_rating_path, params: { rating: invalid_rating }
        expect(response).to have_http_status(422)
      end
      it 'should flash with an error message' do
        post add_rating_path, params: { rating: invalid_rating }
        expect(flash[:error]).not_to be_nil
      end
      it 'should not redirect' do
        post add_rating_path, params: { rating: invalid_rating }
        expect(response).to have_http_status(422)
        expect(response).to render_template(:index)
      end
    end

    context 'when rating a movie in the future' do
      let(:user) { User.first }
      let(:movie) { Movie.first }
      let(:invalid_rating) { { user_id: user.id, score: 11, watched_date: Date.today + 3.days } }
      it 'should not create a new Rating' do
        expect do
          post add_rating_path, params: { rating: invalid_rating }
        end.not_to change(Rating, :count)
      end
      it 'should not create a new Movie' do
        expect do
          post add_rating_path, params: { rating: invalid_rating }
        end.not_to change(Rating, :count)
      end
      it 'shoud respond with a 400 (bad request)' do
        post add_rating_path, params: { rating: invalid_rating }
        expect(response).to have_http_status(422)
      end
      it 'should flash with an error message' do
        post add_rating_path, params: { rating: invalid_rating }
        expect(flash[:error]).not_to be_nil
      end
      it 'should not redirect' do
        post add_rating_path, params: { rating: invalid_rating }
        expect(response).to have_http_status(422)
        expect(response).to render_template(:index)
      end
    end
  end
end

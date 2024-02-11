# frozen_string_literal: true

require 'rails_helper'
require 'benchmark'

RSpec.describe 'Ratings', type: :request do
  let(:controller_instance) { RatingsController.new }
  describe 'GET /ratings' do
    context 'successful request' do
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
        expect(response.body).to include('Ratings')
      end
    end
  end

  describe 'Arrange ratings' do
    let(:ratings) { FactoryBot.create_list(:ratings, 5) }
    context 'when sorting ratings' do
      before do
        @sorted_ratings = controller_instance.send(:sort_rating_sets_by_date)
      end
      it 'sorts paired and orphaned ratings by watched_date' do
        expect(@sorted_ratings).to be_an_instance_of(Array)
        expect(@sorted_ratings[0][0]).to be < @sorted_ratings[1][0]
        # data structure is [watched_date, [ratings]]
      end
    end
  end
end

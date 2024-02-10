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

      it 'should render a list of ratings' do
        get '/ratings'
        expect(response.body).to include('Ratings')
      end
    end
  end

  describe 'Arrange ratings' do
    context 'when pairing ratings' do
      before do
        @ratings = controller_instance.send(:paired_ratings)
      end
      it 'finds all ratings that share a watched_date and movie_id' do
        paired_ratings = controller_instance.send(:paired_ratings)
        expect(paired_ratings[0][0].movie_id).to eq(paired_ratings[0][1].movie_id)
        expect(paired_ratings[0][0].user_id).to_not eq(paired_ratings[0][1].user_id)
      end

      it 'does not pair ratings with different watched_date' do
        paired_ratings = controller_instance.send(:paired_ratings)
        expect(paired_ratings).to_not include(movies(:inside_out))
      end

      context 'when finding orphan ratings' do
        before do
          @orphan_ratings = controller_instance.send(:orphan_ratings)
        end
        it 'returns ratings with no matching pair' do
          orphan_ratings = controller_instance.send(:orphan_ratings)
          expect(orphan_ratings).to include(ratings(:reba_inside_out))
        end
      end
    end
  end
end

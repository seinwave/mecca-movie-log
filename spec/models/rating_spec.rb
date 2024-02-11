# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Ratings model', type: :model do
  describe 'scopes' do
    context 'when .grouped_and_sorted_by_date' do
      it 'sorts paired and orphaned ratings by watched_date' do
        ratings = Rating.grouped_and_sorted_by_date
        expect(ratings[0][0]).to be < ratings[1][0]
        # data structure is [watched_date, [ratings]]
      end
    end
  end

  describe 'validations' do
    context 'when a rating is valid' do
      let(:rating) { FactoryBot.create(:rating) }
      it 'should have a valid score, movie_id, and user_id' do
        expect(rating).to be_valid
      end
    end
    context 'when a rating is invalid' do
      let(:rating) { FactoryBot.build(:rating) }
      it 'should have a score' do
        rating.score = nil
        expect(rating).to_not be_valid
      end
      it 'should have a score within range' do
        rating.score = 0
        expect(rating).to_not be_valid
        rating.score = 16
        expect(rating).to_not be_valid
      end
      it 'should have a movie_id' do
        rating.movie_id = nil
        expect(rating).to_not be_valid
      end
      it 'should have a user_id' do
        rating.user_id = nil
        expect(rating).to_not be_valid
      end
    end
  end
end

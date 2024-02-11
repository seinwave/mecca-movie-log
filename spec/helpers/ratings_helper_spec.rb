# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RatingsHelper, type: :helper do
  describe 'utility methods' do
    context 'when rendering scores' do
      let(:rating) { FactoryBot.build(:rating, movie_id: 5) }
      let(:rating2) { FactoryBot.build(:rating, movie_id: 5) }
      let(:rating3) { FactoryBot.build(:rating, movie_id: 6) }
      let(:rating4) { FactoryBot.build(:rating, movie_id: 6) }
      it 'converts a rating to a letter grade' do
        result = helper.render_rating(Rating.first)
        expect(result).to eq('D')
      end

      it 'groups ratings by movie' do
        result = helper.group_ratings_by_movie([rating, rating2, rating3, rating4])
        expect(result).to eq([{ title: rating.movie.title, ratings: [rating, rating2] }, { title: rating3.movie.title, ratings: [rating3, rating4] }])
      end
    end
  end
end

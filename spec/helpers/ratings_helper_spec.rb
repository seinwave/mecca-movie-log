# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RatingsHelper, type: :helper do
  describe 'utility methods' do
    context 'when rendering scores' do
      let(:rating1) { FactoryBot.build(:rating, movie_id: 5, user_id: 1) }
      let(:rating2) { FactoryBot.build(:rating, movie_id: 5, user_id: 2) }
      let(:rating3) { FactoryBot.build(:rating, movie_id: 6, user_id: 1) }
      let(:rating4) { FactoryBot.build(:rating, movie_id: 6, user_id: 2) }

      it 'converts a rating to a letter grade' do
        result = helper.render_rating(rating1)
        expect(result).to eq('D')
      end

      it 'reports that a user hasnt seen a movie' do
        result = helper.render_rating(nil)
        expect(result).to eq("Hasn't seen")
      end

      it 'groups ratings by movie' do
        result = helper.group_ratings_by_movie([rating1, rating2, rating3, rating4])

        expect(result).to eq([{ title: rating1.movie.title, matt_rating: rating2, reba_rating: rating1 },
                              { title: rating3.movie.title, matt_rating: rating4, reba_rating: rating3 }])
      end
    end
  end
end

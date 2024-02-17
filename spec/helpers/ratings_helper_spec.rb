# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RatingsHelper, type: :helper do
  describe 'utility methods' do
    context 'when rendering scores' do
      let(:matt) { FactoryBot.build(:user, first_name: 'Matt') }
      let(:reba) { FactoryBot.build(:user, first_name: 'Rebecca') }
      let(:rating1) { FactoryBot.build(:rating, movie_id: 5, user_id: matt.id) }
      let(:rating2) { FactoryBot.build(:rating, movie_id: 5, user_id: reba.id) }
      let(:rating3) { FactoryBot.build(:rating, movie_id: 6, user_id: matt.id) }
      let(:rating4) { FactoryBot.build(:rating, movie_id: 6, user_id: reba.id) }

      it 'converts a rating to a letter grade' do
        result = helper.render_rating(rating1)
        expect(result).to eq('D')
      end

      it 'reports that a user hasnt seen a movie' do
        result = helper.render_rating(nil)
        expect(result).to eq("Hasn't seen")
      end

      it 'groups ratings by movie and user' do
        result = helper.group_ratings_by_movie([rating1, rating2, rating3, rating4], matt, reba)


        expect(result).to eq([{ title: rating1.movie.title, user1_rating: rating1, user2_rating: rating2 },
                              { title: rating3.movie.title, user1_rating: rating3, user2_rating: rating4 }])
      end
    end
  end
end

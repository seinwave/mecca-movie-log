# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RatingsHelper, type: :helper do
  describe 'utility methods' do
    context 'when sorting and matching ratings' do
      it 'finds a matching rating, with the same movie, but different user' do
        result = helper.get_complimentary_rating(ratings(:reba_brave))
        expect(result.user.first_name).to eq('Matt')
        expect(result.movie.title).to eq('Brave')
      end
    end

    context 'when rendering scores' do
      it 'converts a rating to a letter grade' do
        result = helper.convert_to_letter_grade(ratings(:reba_brave))
        expect(result).to eq('D+')
      end

      it 'converts a numerical score to a letter grade' do
        result = helper.convert_score_to_letter_grade(8.3)
        expect(result).to eq('C')
      end
    end

    context 'when calculating stats' do
      it 'gets ratings for a movie, from a particular user' do
        result = helper.get_ratings(users(:reba), movies(:brave))
        expect(result[0].score).to eq(6)
      end

      it 'gets ratings for a movie, from all' do
        result = helper.get_ratings(nil, movies(:brave))
        expect(result[0].score).to eq(6)
        expect(result[1].score).to eq(9)
      end

      it 'calculates a running average rating, for one user' do
        result = helper.running_average([users(:reba)])
        expect(result).to eq(8)
      end

      it 'calculates a running average rating, multiple users' do
        result = helper.running_average([users(:reba), users(:matt)])
        expect(result).to eq(8.3)
      end

      it 'finds the movies with the highest average ratings' do
        result = helper.highest_rated_movies(1)
        expect(result[0].title).to eq('Hoop Dreams')
        expect(result.length).to eq(1)
      end

      it 'returns the highest rated movies titles, with matt and rebas respective scores' do
        result = helper.highest_rated_movies_with_scores(1)
        expect(result[0].title).to eq('Hoop Dreams')
        expect(result[0].matt_score).to eq('B-')
        expect(result[0].reba_score).to eq('B-')
      end

      it 'finds the movie where matt and reba disagree the most on the score' do
        result = helper.biggest_divergence
        expect(result.title).to eq('Brave')
      end
    end
  end
end

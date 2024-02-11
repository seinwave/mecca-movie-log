# TKTK

require 'rails_helper'

RSpec.describe 'Ratings model', type: :controller do 
   describe 'scopes' do
    let (:same_date_ratings) {FactoryBot.create_list(:rating_with_same_movie_and_same_date, 3)}
    let(:ratings) { FactoryBot.create_list(:rating, 5) }
    context 'when .grouped_and_sorted_by_date' do
      it 'sorts paired and orphaned ratings by watched_date' do
        ratings = Rating.grouped_and_sorted_by_date
        expect(ratings[0][0]).to be < ratings[1][0]
        # data structure is [watched_date, [ratings]]
      end
    end
  end
end

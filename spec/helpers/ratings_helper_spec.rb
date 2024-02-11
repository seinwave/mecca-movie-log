# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RatingsHelper, type: :helper do
  describe 'utility methods' do

    let(:ratings) { FactoryBot.create_list(:rating, 5) }

    context 'when rendering scores' do
      it 'converts a rating to a letter grade' do
        result = helper.render_rating(ratings[0])
        expect(result).to eq('D')
      end
    end

  end
end

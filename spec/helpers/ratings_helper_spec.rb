# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RatingsHelper, type: :helper do
  describe 'utility methods' do

    let(:rating) { FactoryBot.create(:rating) }
    
    context 'when rendering scores' do
      it 'converts a rating to a letter grade' do
        result = helper.render_rating(rating)
        expect(result).to eq('D')
      end
    end
  end
end

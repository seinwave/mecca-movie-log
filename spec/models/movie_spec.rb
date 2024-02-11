# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Movie model', type: :model do
  describe 'validations' do
    context 'when a movie is valid' do
      let(:movie) { FactoryBot.build(:movie) }
      it 'should have a valid title' do
        expect(movie).to be_valid
      end
    end
    context 'when a movie is invalid' do
      let(:movie) { FactoryBot.build(:movie) }
      it 'should have a title' do
        movie.title = nil
        expect(movie).to_not be_valid
      end
    end
  end
end

require 'rails_helper'

RSpec.describe "Ratings", type: :request do
  describe 'utility methods' do 
    it 'converts a rating to a letter grade' do
      rating = RatingsController.new
      result = rating.convert_to_letter_grade(11)
      expect(result).to eq('B')
    end
  end 
end

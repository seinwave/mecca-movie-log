# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the RatingsHelper. For example:
#
# describe RatingsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe RatingsHelper, type: :helper do
  describe 'utility methods' do

    it 'converts a rating to a letter grade' do
      result = helper.convert_to_letter_grade(ratings(:reba_brave))
      expect(result).to eq('D+')
    end

    it 'calculates a running average rating, for one user' do 
      result = helper.running_average([users(:reba)])
      expect(result).to eq(8)
    end

    it 'calculates a running average rating, multiple users' do 
      result = helper.running_average([users(:reba), users(:matt)])
      expect(result).to eq(8.3)
    end
  end
end

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
    fixtures :ratings 

    it 'converts a rating to a letter grade' do
      result = helper.convert_to_letter_grade(ratings(:reba_brave))
      expect(result).to eq('D+')
    end
  end
end

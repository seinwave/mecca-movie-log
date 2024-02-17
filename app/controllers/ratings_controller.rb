# frozen_string_literal: true

class RatingsController < ApplicationController
  def index
    @ratings = Rating.grouped_and_sorted_by_date
    @rebecca = User.find_by(first_name: 'Rebecca')
    @matt = User.find_by(first_name: 'Matt')
  end
end

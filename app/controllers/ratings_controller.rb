# frozen_string_literal: true

class RatingsController < ApplicationController
  def index
    @ratings = Rating.grouped_and_sorted_by_date
  end
end

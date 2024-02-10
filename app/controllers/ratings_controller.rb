# frozen_string_literal: true

class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
  end

  def sort_rating_sets_by_date
    @rating_sets = Rating.all.group_by(&:watched_date).sort_by { |date, _ratings| date }
  end
end

# frozen_string_literal: true

class Rating < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  scope :grouped_and_sorted_by_date, -> { all.group_by(&:watched_date).sort_by { |date, _ratings| date } }
end

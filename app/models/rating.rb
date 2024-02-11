# frozen_string_literal: true

class Rating < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  scope :grouped_and_sorted_by_date, -> { all.group_by(&:watched_date).sort_by { |date, _ratings| date } }

  validates :score, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 15 }
  validates :movie_id, presence: true
  validates :user_id, presence: true
end

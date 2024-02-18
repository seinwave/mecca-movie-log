# frozen_string_literal: true

class Rating < ApplicationRecord
  belongs_to :movie
  accepts_nested_attributes_for :movie
  belongs_to :user

  scope :grouped_and_sorted_by_date, -> { all.group_by(&:watched_date).sort_by { |date, _ratings| date }.reverse }

  validates :score, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 15 }
  validates :movie_id, presence: true
  validates :user_id, presence: true
  validates :watched_date, presence: true

  validate :watched_date_cannot_be_in_the_future

  def watched_date_cannot_be_in_the_future
    return unless watched_date.present? && watched_date > Date.today

    errors.add(:watched_date, "can't be in the future")
  end
end

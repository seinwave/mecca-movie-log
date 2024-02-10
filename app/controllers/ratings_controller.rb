# frozen_string_literal: true

class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
  end

  def paired_ratings
    Rating.select(:movie_id, :watched_date)
          .group(:movie_id, :watched_date)
          .having('count(*) > 1')
          .map { |r| Rating.where(movie_id: r.movie_id, watched_date: r.watched_date) }
  end

  def orphan_ratings
    paired_movie_ids_and_dates = paired_ratings.flatten.map { |rating| [rating.movie_id, rating.watched_date] }
    Rating.where.not(movie_id: paired_movie_ids_and_dates.map(&:first),
                     watched_date: paired_movie_ids_and_dates.map(&:last))
  end
end

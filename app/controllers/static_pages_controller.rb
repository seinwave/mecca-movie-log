# frozen_string_literal: true

class StaticPagesController < ApplicationController
  include RatingsHelper

  def stats
    reba = User.where(first_name: 'Reba').first
    matt = User.where(first_name: 'Matt').first
    @count = Movie.count
    @reba_average = convert_score_to_letter_grade(running_average([reba]))
    @matt_average = convert_score_to_letter_grade(running_average([matt]))
    @combined_average = convert_score_to_letter_grade(running_average([matt, reba]))
    @household_favorites = highest_rated_movies(10)
    @biggest_divergence = biggest_divergence
    @matt_score_on_divergence = convert_to_letter_grade(Rating.where(movie_id: @biggest_divergence.id, user_id: matt.id).first)
    @reba_score_on_divergence = convert_to_letter_grade(Rating.where(movie_id: @biggest_divergence.id, user_id: reba.id).first)
  end
end

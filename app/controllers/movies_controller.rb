# frozen_string_literal: true

require 'pry'
class MoviesController < ApplicationController
  include RatingsHelper

  def index
    @movies = MoviesController.sort(Movie.all)
  end

  def self.sort(movies)
  movies_with_watched_dates = movies.select do |movie|
    movie.ratings.any? && movie.ratings.all? { |rating| rating.watched_date.present? }
  end

  sorted_movies = movies_with_watched_dates.sort_by do |movie|
    movie.ratings.map(&:watched_date).max
  end.reverse

  sorted_movies
end

end

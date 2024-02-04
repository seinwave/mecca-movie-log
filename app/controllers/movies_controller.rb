# frozen_string_literal: true
require 'pry'
class MoviesController < ApplicationController
  include RatingsHelper

  def index
    @movies = MoviesController.sort(Movie.all)
  end

  def self.sort(movies)
    movies.sort_by do |movie |
      movie.ratings.first.watched_date || movie.ratings.last.watched_date
    end.reverse
  end
end

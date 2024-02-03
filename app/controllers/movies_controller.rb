class MoviesController < ApplicationController
  
  def index 
    @movies = MoviesController.sort(Movie.all)
  end


  private

  def self.sort(movies)
    movies.sort_by { |movie| 
    movie.ratings.first.watched_date || movie.ratings.last.watched_date }
  end

end

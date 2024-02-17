# frozen_string_literal: true

class RatingsController < ApplicationController
  def index
    @ratings = Rating.grouped_and_sorted_by_date
    @rebecca = User.find_by(first_name: 'Rebecca')
    @matt = User.find_by(first_name: 'Matt')
    @rating = Rating.new(watched_date: Date.today)
  end

  def create
    date_params = params[:rating].slice("watched_date(1i)", "watched_date(2i)", "watched_date(3i)")
    watched_date = Date.new(date_params["watched_date(1i)"].to_i, date_params["watched_date(2i)"].to_i, date_params["watched_date(3i)"].to_i)

    rating_params = params.require(:rating).permit(:score, :user_id, :movie_id)
    rating_params[:watched_date] = watched_date

    @rating = Rating.new(rating_params)

    if @rating.save
      redirect_to ratings_path, notice: 'Rating was successfully created.'
    else
      render :new
    end
  end
end

# frozen_string_literal: true

class RatingsController < ApplicationController
  def index
    @ratings = Rating.grouped_and_sorted_by_date
    @rebecca = User.find_by(first_name: 'Rebecca')
    @matt = User.find_by(first_name: 'Matt')
    date = Date.today.strftime("%Y/%m/%d")
    @rating = Rating.new(watched_date: date)
    @rating.build_movie
  end

  def create
    @rating = Rating.new(rating_params)


    if @rating.save
      flash[:success] = 'Rating was successfully saved'
      redirect_to ratings_path
    else
      flash[:error] = 'There was an error recording your rating. Try again!'
    end
  end

  private 

  def rating_params
    params.require(:rating).permit(:score, :movie_id, :user_id, :watched_date, movie_attributes: [:title])
  end 
end

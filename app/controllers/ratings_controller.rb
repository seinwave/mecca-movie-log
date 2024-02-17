# frozen_string_literal: true

class RatingsController < ApplicationController
  def index
    @ratings = Rating.grouped_and_sorted_by_date
    @rebecca = User.find_by(first_name: 'Rebecca')
    @matt = User.find_by(first_name: 'Matt')
  end

  def create
    new_rating = Rating.new(user_id: params[:user_id], movie_id: params[:movie_id], score: params[:score], watched_date: params[:watched_date] )

    if !new_rating.save
      flash[:error] = 'There was an error saving your rating'
    else
      flash[:success] =  'Rating successful'
      redirect_to ratings_path
    end 
  
  end 
end

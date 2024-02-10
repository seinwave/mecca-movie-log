# frozen_string_literal: true

class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
  end
end

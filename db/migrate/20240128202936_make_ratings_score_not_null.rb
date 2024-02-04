# frozen_string_literal: true

class MakeRatingsScoreNotNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :ratings, :score, false
  end
end
